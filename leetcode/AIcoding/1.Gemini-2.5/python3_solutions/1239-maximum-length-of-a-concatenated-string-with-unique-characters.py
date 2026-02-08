from typing import List

class Solution:
    def maxLength(self, arr: List[str]) -> int:
        filtered_arr = []
        for s in arr:
            char_mask = 0
            is_unique = True
            for char_code in map(ord, s):
                bit = 1 << (char_code - ord('a'))
                if (char_mask & bit) != 0:
                    is_unique = False
                    break
                char_mask |= bit
            if is_unique:
                filtered_arr.append((char_mask, len(s)))

        max_len = 0

        def backtrack(index, current_mask, current_length):
            nonlocal max_len
            max_len = max(max_len, current_length)

            if index == len(filtered_arr):
                return

            # Option 1: Exclude filtered_arr[index]
            backtrack(index + 1, current_mask, current_length)

            # Option 2: Include filtered_arr[index]
            word_mask, word_len = filtered_arr[index]

            # Check for conflicts with current_mask
            if (current_mask & word_mask) == 0:
                backtrack(index + 1, current_mask | word_mask, current_length + word_len)

        backtrack(0, 0, 0)
        return max_len