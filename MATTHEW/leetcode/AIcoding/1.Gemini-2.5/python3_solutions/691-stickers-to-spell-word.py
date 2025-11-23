import collections

class Solution:
    def minStickers(self, stickers: list[str], target: str) -> int:
        n = len(target)
        memo = {}

        # Preprocess stickers into character count arrays (size 26 for 'a' through 'z')
        sticker_counts_list = []
        for sticker in stickers:
            counts = [0] * 26
            for char_code in sticker:
                counts[ord(char_code) - ord('a')] += 1
            sticker_counts_list.append(counts)

        # Recursive function with memoization
        # current_target_str is a string representing the remaining characters needed, sorted alphabetically.
        def dp(current_target_str: str) -> int:
            if not current_target_str:
                return 0

            if current_target_str in memo:
                return memo[current_target_str]

            res = float('inf')

            # Get character counts for the current target string
            current_target_char_counts = [0] * 26
            for char_code in current_target_str:
                current_target_char_counts[ord(char_code) - ord('a')] += 1

            # Optimization: Focus on the first character of the current_target_str.
            # This ensures that for a given target state, we only try stickers that
            # can actually cover at least one instance of its first character.
            # This prunes the search space significantly.
            first_char_val = ord(current_target_str[0]) - ord('a')

            for s_counts in sticker_counts_list:
                # Only consider stickers that contain the first character needed by the target
                if s_counts[first_char_val] == 0:
                    continue

                # Create a temporary copy of target counts to simulate applying the sticker
                temp_target_char_counts = list(current_target_char_counts)

                # Apply the sticker: subtract its character counts from target counts
                for i in range(26):
                    if temp_target_char_counts[i] > 0: # Only subtract if target needs this char
                        temp_target_char_counts[i] = max(0, temp_target_char_counts[i] - s_counts[i])

                # Reconstruct the new target string from temp_target_char_counts
                new_target_chars = []
                for i in range(26):
                    new_target_chars.extend([chr(ord('a') + i)] * temp_target_char_counts[i])
                new_target_str = "".join(new_target_chars)

                # If the sticker didn't reduce the target string, it's not a useful step for this branch.
                # This can happen if the sticker only provides characters not needed by current_target_str
                # (even if it has the first char, e.g., target="apple", sticker="apply", first_char='a',
                # but 'y' is not in target, this is fine, but if it didn't reduce 'a', 'p', 'l', 'e' it's useless).
                if new_target_str == current_target_str:
                    continue

                # Recursive call
                sub_res = dp(new_target_str)
                if sub_res != -1: # -1 indicates that it's impossible to form the sub-target
                    res = min(res, 1 + sub_res)

            # Store and return result
            memo[current_target_str] = res if res != float('inf') else -1
            return memo[current_target_str]

        # Initial call: The target string must be sorted to ensure consistent memoization keys.
        sorted_target = "".join(sorted(target))
        result = dp(sorted_target)
        return result