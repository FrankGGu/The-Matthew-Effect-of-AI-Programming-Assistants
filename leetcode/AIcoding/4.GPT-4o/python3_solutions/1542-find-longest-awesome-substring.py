class Solution:
    def longestAwesome(self, s: str) -> int:
        n = len(s)
        longest = 0
        mask = 0
        seen = {0: -1}

        for i in range(n):
            mask ^= 1 << (ord(s[i]) - ord('0'))
            if mask in seen:
                longest = max(longest, i - seen[mask])
            for j in range(10):
                if mask ^ (1 << j) in seen:
                    longest = max(longest, i - seen[mask ^ (1 << j)])
            if mask not in seen:
                seen[mask] = i

        return longest