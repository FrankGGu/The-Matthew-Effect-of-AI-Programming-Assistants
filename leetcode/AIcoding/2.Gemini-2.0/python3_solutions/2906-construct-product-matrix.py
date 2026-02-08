class Solution:
    def constructProductMatrix(self, grid: List[List[int]]) -> List[List[int]]:
        m = len(grid)
        n = len(grid[0])
        total_product = 1
        zeros_count = 0
        zero_pos = []
        MOD = 12345

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 0:
                    zeros_count += 1
                    zero_pos.append((i, j))
                else:
                    total_product = (total_product * grid[i][j]) % MOD

        result = [[0] * n for _ in range(m)]

        if zeros_count > 1:
            return result
        elif zeros_count == 1:
            zero_i, zero_j = zero_pos[0]
            result[zero_i][zero_j] = total_product
            return result
        else:
            for i in range(m):
                for j in range(n):
                    result[i][j] = (total_product * pow(grid[i][j], MOD - 2, MOD)) % MOD
            return result