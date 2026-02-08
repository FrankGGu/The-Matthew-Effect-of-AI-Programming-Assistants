class Solution:
    def smallestSubstring(self, s: str) -> int:
        if not s:
            return -1

        min_len = float('inf')
        n = len(s)

        for i in range(n):
            if i + 1 < n and s[i] == s[i + 1]:
                left = i
                right = i + 1
                while right < n and s[right] == s[left]:
                    right += 1
                current_len = right - left
                if current_len >= 2:
                    min_len = min(min_len, current_len)

        return min_len if min_len != float('inf') else -1