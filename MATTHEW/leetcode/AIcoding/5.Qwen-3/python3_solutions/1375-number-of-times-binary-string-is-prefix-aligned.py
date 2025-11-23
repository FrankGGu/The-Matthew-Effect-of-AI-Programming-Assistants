class Solution:
    def numberOfTimeBinaryStringIsPrefixAligned(self, s: str) -> int:
        count = 0
        max_reach = 0
        for i in range(len(s)):
            if s[i] == '1':
                max_reach = max(max_reach, i + 1)
            if max_reach == i + 1:
                count += 1
        return count