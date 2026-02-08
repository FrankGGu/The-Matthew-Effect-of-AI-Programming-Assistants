class Solution:
    def longestSemiRepetitiveSubstring(self, s: str) -> int:
        n = len(s)
        if n <= 2:
            return n

        max_len = 0
        left = 0
        count = 0 

        for right in range(n):
            if right > 0 and s[right] == s[right-1]:
                count += 1

            while count > 2:
                if s[left] == s[left+1]:
                    count -= 1
                left += 1

            max_len = max(max_len, right - left + 1)

        return max_len