class Solution:
    def grayCode(self, n: int) -> list[int]:
        if n == 0:
            return [0]

        result = [0, 1]
        for i in range(1, n):
            mask = 1 << i
            for j in range(len(result) - 1, -1, -1):
                result.append(result[j] | mask)

        return result