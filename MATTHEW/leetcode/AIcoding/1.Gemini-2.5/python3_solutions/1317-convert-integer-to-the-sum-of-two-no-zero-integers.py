class Solution:
    def getNoZeroIntegers(self, n: int) -> list[int]:
        def is_no_zero(num: int) -> bool:
            return '0' not in str(num)

        for i in range(1, n):
            j = n - i
            if is_no_zero(i) and is_no_zero(j):
                return [i, j]
        return []