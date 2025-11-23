class Solution:
    def minimumMoney(self, transactions: List[List[int]]) -> int:
        total_loss = 0
        max_cashback = 0
        max_cost = 0

        for cost, cashback in transactions:
            if cost > cashback:
                total_loss += cost - cashback
                max_cashback = max(max_cashback, cashback)
            else:
                max_cost = max(max_cost, cost)

        return total_loss + max(max_cashback, max_cost)