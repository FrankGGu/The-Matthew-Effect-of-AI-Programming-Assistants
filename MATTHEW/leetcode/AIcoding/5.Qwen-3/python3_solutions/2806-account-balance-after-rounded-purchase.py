class Solution:
    def accountBalance(self, purchaseAmount: int) -> int:
        return purchaseAmount - (purchaseAmount % 10)