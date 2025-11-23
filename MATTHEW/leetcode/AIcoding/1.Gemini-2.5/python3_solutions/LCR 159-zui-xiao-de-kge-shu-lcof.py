class Solution:
    def inventoryManagement(self, stock: list[int], k: int) -> int:
        stock.sort()
        MOD = 10**9 + 7
        total_sum = 0
        for i in range(k):
            total_sum = (total_sum + stock[i]) % MOD
        return total_sum