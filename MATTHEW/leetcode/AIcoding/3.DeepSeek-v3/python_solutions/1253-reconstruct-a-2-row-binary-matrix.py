class Solution:
    def reconstructMatrix(self, upper: int, lower: int, colsum: List[int]) -> List[List[int]]:
        n = len(colsum)
        res = [[0] * n for _ in range(2)]

        for j in range(n):
            if colsum[j] == 2:
                res[0][j] = res[1][j] = 1
                upper -= 1
                lower -= 1

        for j in range(n):
            if colsum[j] == 1:
                if upper > 0:
                    res[0][j] = 1
                    upper -= 1
                else:
                    res[1][j] = 1
                    lower -= 1

        if upper == 0 and lower == 0:
            return res
        else:
            return []