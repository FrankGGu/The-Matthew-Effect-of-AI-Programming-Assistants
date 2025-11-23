class Solution:
    def constructProductMatrix(self, grid: list[list[int]]) -> list[list[int]]:
        R = len(grid)
        C = len(grid[0])
        MOD = 12345

        N = R * C

        prefix_products = [1] * N
        suffix_products = [1] * N

        current_product = 1
        for r in range(R):
            for c in range(C):
                k = r * C + c
                prefix_products[k] = current_product
                current_product = (current_product * grid[r][c]) % MOD

        current_product = 1
        for r in range(R - 1, -1, -1):
            for c in range(C - 1, -1, -1):
                k = r * C + c
                suffix_products[k] = current_product
                current_product = (current_product * grid[r][c]) % MOD

        product_matrix = [[0] * C for _ in range(R)]
        for r in range(R):
            for c in range(C):
                k = r * C + c
                product_matrix[r][c] = (prefix_products[k] * suffix_products[k]) % MOD

        return product_matrix