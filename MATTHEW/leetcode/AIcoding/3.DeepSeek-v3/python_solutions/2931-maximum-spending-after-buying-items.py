class Solution:
    def maxSpending(self, values: List[List[int]]) -> int:
        m = len(values)
        n = len(values[0])
        products = []
        for i in range(m):
            for j in range(n):
                products.append(values[i][j])
        products.sort()
        total = 0
        for day in range(1, len(products) + 1):
            total += day * products[day - 1]
        return total