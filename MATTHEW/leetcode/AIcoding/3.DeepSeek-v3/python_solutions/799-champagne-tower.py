class Solution:
    def champagneTower(self, poured: int, query_row: int, query_glass: int) -> float:
        tower = [[0.0] * (i + 1) for i in range(query_row + 1)]
        tower[0][0] = poured

        for i in range(query_row):
            for j in range(len(tower[i])):
                excess = (tower[i][j] - 1.0) / 2.0
                if excess > 0:
                    tower[i + 1][j] += excess
                    tower[i + 1][j + 1] += excess

        return min(1.0, tower[query_row][query_glass])