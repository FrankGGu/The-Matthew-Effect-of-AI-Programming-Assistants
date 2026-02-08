class Solution:
    def accountBalance(self, purchaseAmount: int) -> int:
        return 100 - (purchaseAmount + 5) // 10 * 10