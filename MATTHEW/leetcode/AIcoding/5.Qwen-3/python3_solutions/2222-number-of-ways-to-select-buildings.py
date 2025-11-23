class Solution:
    def numberOfWays(self, s: str) -> int:
        zeros = []
        ones = []
        for i, c in enumerate(s):
            if c == '0':
                zeros.append(i)
            else:
                ones.append(i)
        res = 0
        for i in range(len(s)):
            if s[i] == '0':
                left_ones = len(ones) - bisect.bisect_left(ones, i)
                right_ones = len(ones) - bisect.bisect_right(ones, i)
                res += left_ones * right_ones
            else:
                left_zeros = len(zeros) - bisect.bisect_left(zeros, i)
                right_zeros = len(zeros) - bisect.bisect_right(zeros, i)
                res += left_zeros * right_zeros
        return res