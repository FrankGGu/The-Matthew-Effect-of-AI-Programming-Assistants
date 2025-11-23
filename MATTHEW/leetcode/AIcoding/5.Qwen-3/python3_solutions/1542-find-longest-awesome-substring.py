class Solution:
    def longestAwesome(self, s: str) -> int:
        last_occurrence = [ -1 ] * 1024
        for i in range(1024):
            last_occurrence[i] = -1
        result = 0
        mask = 0
        for i in range(len(s)):
            digit = int(s[i])
            mask ^= (1 << digit)
            if last_occurrence[mask] == -1:
                last_occurrence[mask] = i
            else:
                result = max(result, i - last_occurrence[mask])
            for j in range(10):
                temp_mask = mask ^ (1 << j)
                if last_occurrence[temp_mask] != -1:
                    result = max(result, i - last_occurrence[temp_mask])
        return result