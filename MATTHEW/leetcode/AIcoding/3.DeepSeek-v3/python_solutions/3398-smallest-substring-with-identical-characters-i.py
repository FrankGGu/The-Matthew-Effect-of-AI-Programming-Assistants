class Solution:
    def smallestSubstring(self, s: str) -> int:
        min_len = float('inf')
        n = len(s)
        if n == 0:
            return -1

        current_char = s[0]
        current_len = 1

        for i in range(1, n):
            if s[i] == current_char:
                current_len += 1
            else:
                if current_len < min_len:
                    min_len = current_len
                current_char = s[i]
                current_len = 1

        if current_len < min_len:
            min_len = current_len

        return min_len if min_len != float('inf') else -1