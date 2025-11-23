class Solution:
    def splitString(self, s: str) -> bool:
        def can_split(start, prev):
            if start == len(s):
                return True
            for length in range(1, len(s) - start + 1):
                num_str = s[start:start + length]
                if (len(num_str) > 1 and num_str[0] == '0') or int(num_str) != prev - 1:
                    continue
                if can_split(start + length, int(num_str)):
                    return True
            return False

        for length in range(1, len(s)):
            if can_split(length, int(s[:length])):
                return True
        return False