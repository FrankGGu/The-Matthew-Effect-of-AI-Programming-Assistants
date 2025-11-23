class Solution:
    def minimumMoney(self, transactions: List[List[int]]) -> int:
        min_money = 0
        total_deficit = 0

        for gain, loss in transactions:
            if gain < loss:
                total_deficit += loss - gain

        for gain, loss in transactions:
            if gain < loss:
                min_money = max(min_money, loss - gain)

        return min_money + total_deficit