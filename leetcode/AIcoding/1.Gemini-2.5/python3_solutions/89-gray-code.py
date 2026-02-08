class Solution:
    def grayCode(self, n: int) -> list[int]:
        result = []
        num_codes = 1 << n
        for i in range(num_codes):
            result.append(i ^ (i >> 1))
        return result