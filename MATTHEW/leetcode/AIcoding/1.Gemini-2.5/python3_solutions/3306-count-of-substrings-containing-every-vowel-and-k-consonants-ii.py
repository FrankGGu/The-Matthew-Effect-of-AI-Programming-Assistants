class Solution:
    def countSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        ans = 0

        vowels = {'a', 'e', 'i', 'o', 'u'}

        last_vowel_indices = {'a': -1, 'e': -1, 'i': -1, 'o': -1, 'u': -1}
        consonant_indices = []

        for right in range(n):
            char_r = s[right]

            if char_r in vowels:
                last_vowel_indices[char_r] = right
            else:
                consonant_indices.append(right)

            # --- Check for 'all vowels present' condition ---
            min_all_vowels_idx = float('inf')
            all_vowels_present = True
            for v in vowels:
                if last_vowel_indices[v] == -1:
                    all_vowels_present = False
                    break
                min_all_vowels_idx = min(min_all_vowels_idx, last_vowel_indices[v])

            if not all_vowels_present:
                continue

            # The valid range for 'left' based on vowels is [0, min_all_vowels_idx].
            # Any 'left' in this range ensures that s[left...right] contains all 5 vowels.
            effective_left_vowel_end = min_all_vowels_idx
            effective_left_vowel_start = 0

            # --- Check for 'exactly k consonants' condition ---
            num_consonants_in_prefix = len(consonant_indices)

            left_cons_start = 0
            left_cons_end = 0

            if k == 0:
                left_cons_start = 0
                left_cons_end = right
            elif num_consonants_in_prefix < k:
                continue
            else: # num_consonants_in_prefix >= k and k > 0
                # left_cons_end is the index of the k-th consonant from the right (0-indexed)
                # This means s[left_cons_end...right] will have at least k consonants, and if left_cons_end is a consonant, it's the k-th.
                left_cons_end = consonant_indices[num_consonants_in_prefix - k]

                # left_cons_start is the index after the (k-1)-th consonant from the right.
                # If there are exactly k consonants, this will be 0.
                if num_consonants_in_prefix > k:
                    left_cons_start = consonant_indices[num_consonants_in_prefix - k - 1] + 1
                else: # num_consonants_in_prefix == k
                    left_cons_start = 0

            # Combine conditions to find the final range for 'left'
            final_left_start = max(effective_left_vowel_start, left_cons_start)
            final_left_end = min(effective_left_vowel_end, left_cons_end)

            if final_left_start <= final_left_end:
                ans += (final_left_end - final_left_start + 1)

        return ans