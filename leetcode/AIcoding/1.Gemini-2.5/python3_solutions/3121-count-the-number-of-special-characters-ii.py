class Solution:
    def numberOfSpecialChars(self, s: str) -> int:
        max_lower_idx = [-1] * 26  # Stores the maximum index for each lowercase letter
        min_upper_idx = [float('inf')] * 26  # Stores the minimum index for each uppercase letter

        for i, char in enumerate(s):
            if 'a' <= char <= 'z':
                idx = ord(char) - ord('a')
                max_lower_idx[idx] = max(max_lower_idx[idx], i)
            elif 'A' <= char <= 'Z':
                idx = ord(char) - ord('A')
                min_upper_idx[idx] = min(min_upper_idx[idx], i)

        special_char_count = 0
        for i in range(26):
            # Check if the lowercase character exists, its uppercase counterpart exists,
            # and all occurrences of the lowercase character appear before all occurrences
            # of its uppercase counterpart.
            if max_lower_idx[i] != -1 and min_upper_idx[i] != float('inf') and max_lower_idx[i] < min_upper_idx[i]:
                special_char_count += 1

        return special_char_count