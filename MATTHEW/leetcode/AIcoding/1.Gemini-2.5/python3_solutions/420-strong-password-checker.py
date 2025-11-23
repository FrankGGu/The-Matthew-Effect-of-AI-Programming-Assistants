import collections

class Solution:
    def strongPasswordChecker(self, s: str) -> int:
        n = len(s)

        has_lower = False
        has_upper = False
        has_digit = False
        for char in s:
            if 'a' <= char <= 'z':
                has_lower = True
            elif 'A' <= char <= 'Z':
                has_upper = True
            elif '0' <= char <= '9':
                has_digit = True

        missing_types = (not has_lower) + (not has_upper) + (not has_digit)

        # Calculate replacements needed for repeating characters
        # Store lengths of repeating sequences (e.g., "aaa" -> 3, "bbbbb" -> 5)
        repeats = []
        i = 0
        while i < n:
            j = i
            while j < n and s[j] == s[i]:
                j += 1
            length = j - i
            if length >= 3:
                repeats.append(length)
            i = j

        # total_replacements_for_repeats is the sum of (L // 3) for each repeat
        # This is the minimum replacements needed if no other operations are considered
        total_replacements_for_repeats = sum(L // 3 for L in repeats)

        ans = 0

        if n < 6:
            # Case 1: Password is too short
            # We need to add (6 - n) characters.
            # These insertions can cover missing types and break repeating sequences.
            # The number of operations is at least (6 - n) (for length) and at least missing_types (for types).
            # So, initial operations = max(missing_types, 6 - n).
            # Each insertion can also break one repeating sequence (reduce L//3 by 1 effectively).
            # So, the effective number of repeats needing replacement is max(0, total_replacements_for_repeats - (6 - n)).
            # These remaining repeats must be fixed by additional replacements.
            ans = max(missing_types, 6 - n) + max(0, total_replacements_for_repeats - (6 - n))

        elif n > 20:
            # Case 2: Password is too long
            # We must perform (n - 20) deletions.
            # These deletions contribute to the total answer.
            ans = n - 20
            deletions_to_make = n - 20

            # Deletions can also reduce the number of replacements needed for repeating characters.
            # We prioritize deletions to maximize the reduction in total_replacements_for_repeats.
            # 1. Delete from sequences where L % 3 == 0: Each deletion reduces L//3 by 1. (e.g., "aaaaaa" -> "aaaaa", 2 replacements -> 1 replacement).
            # 2. Delete from sequences where L % 3 == 1: Each 2 deletions reduces L//3 by 1. (e.g., "aaaa" -> "aa", 1 replacement -> 0 replacements).
            # 3. Delete from sequences where L % 3 == 2: Each 3 deletions reduces L//3 by 1. (e.g., "aaaaa" -> "aa", 1 replacement -> 0 replacements).

            # Group repeats by L % 3
            mod_0_repeats = []
            mod_1_repeats = []
            mod_2_repeats = []
            for L in repeats:
                if L % 3 == 0:
                    mod_0_repeats.append(L)
                elif L % 3 == 1:
                    mod_1_repeats.append(L)
                else:
                    mod_2_repeats.append(L)

            # Sort to prioritize smaller lengths within each group (might not be strictly necessary but good practice)
            mod_0_repeats.sort()
            mod_1_repeats.sort()
            mod_2_repeats.sort()

            # Apply deletions greedily
            # Priority 1: L % 3 == 0
            for L in mod_0_repeats:
                if deletions_to_make == 0:
                    break
                # Each deletion here saves 1 replacement
                can_delete = min(deletions_to_make, L // 3)
                total_replacements_for_repeats -= can_delete
                deletions_to_make -= can_delete

            # Priority 2: L % 3 == 1
            for L in mod_1_repeats:
                if deletions_to_make < 2:
                    break
                # Each 2 deletions here save 1 replacement
                can_delete = min(deletions_to_make // 2, L // 3)
                total_replacements_for_repeats -= can_delete
                deletions_to_make -= can_delete * 2

            # Priority 3: L % 3 == 2
            for L in mod_2_repeats:
                if deletions_to_make < 3:
                    break
                # Each 3 deletions here save 1 replacement
                can_delete = min(deletions_to_make // 3, L // 3)
                total_replacements_for_repeats -= can_delete
                deletions_to_make -= can_delete * 3

            # After specific reductions, any remaining deletions can reduce total_replacements_for_repeats 1-to-1.
            total_replacements_for_repeats -= min(deletions_to_make, total_replacements_for_repeats)

            # The final answer is deletions_needed + max(missing_types, remaining_replacements_for_repeats)
            ans += max(missing_types, total_replacements_for_repeats)

        else:
            # Case 3: 6 <= n <= 20
            # No length constraint operations (insertions/deletions).
            # We only need to consider replacements for missing types and repeating characters.
            # An operation can satisfy a missing type and fix a repeat simultaneously.
            ans = max(missing_types, total_replacements_for_repeats)

        return ans