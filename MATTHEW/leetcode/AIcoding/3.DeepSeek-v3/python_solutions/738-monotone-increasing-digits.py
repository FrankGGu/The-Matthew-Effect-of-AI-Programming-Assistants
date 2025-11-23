class Solution:
    def monotoneIncreasingDigits(self, n: int) -> int:
        s = list(str(n))
        length = len(s)
        marker = length

        for i in range(length - 1, 0, -1):
            if s[i] < s[i - 1]:
                marker = i
                s[i - 1] = str(int(s[i - 1]) - 1)

        for i in range(marker, length):
            s[i] = '9'

        return int(''.join(s))