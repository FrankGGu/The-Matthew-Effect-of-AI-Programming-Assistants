class Solution:
    def monotoneIncreasingDigits(self, N: int) -> int:
        s = list(str(N))
        n = len(s)
        mark = n

        for i in range(n - 1, 0, -1):
            if s[i] < s[i - 1]:
                mark = i
                s[i - 1] = str(int(s[i - 1]) - 1)

        for i in range(mark, n):
            s[i] = '9'

        return int(''.join(s))