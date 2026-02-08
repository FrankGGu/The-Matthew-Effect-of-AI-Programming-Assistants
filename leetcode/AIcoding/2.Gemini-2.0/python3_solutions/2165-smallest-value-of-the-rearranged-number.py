class Solution:
    def smallestNumber(self, num: int) -> int:
        s = list(str(abs(num)))
        s.sort()
        if num > 0:
            if s[0] == '0':
                i = 0
                while s[i] == '0':
                    i += 1
                s[0], s[i] = s[i], s[0]
            return int("".join(s))
        else:
            s.reverse()
            return -int("".join(s))