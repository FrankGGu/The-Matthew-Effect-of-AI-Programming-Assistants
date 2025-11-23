class Solution:
    def accountBalanceAfterPurchase(self, purchaseAmount: int) -> int:
        rounded_amount = round(purchaseAmount / 10) * 10
        return 100 - rounded_amount