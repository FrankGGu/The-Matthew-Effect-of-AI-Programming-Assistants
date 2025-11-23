class Solution:
    def judgeSquareSum(self, c: int) -> bool:
        import math
        max_num = int(math.isqrt(c))
        for i in range(max_num + 1):
            j = math.isqrt(c - i * i)
            if j * j == c - i * i:
                return True
        return False