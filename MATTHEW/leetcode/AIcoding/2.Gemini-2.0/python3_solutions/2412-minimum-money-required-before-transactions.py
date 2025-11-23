class Solution:
    def minimumMoney(self, transactions: list[list[int]]) -> int:
        loss = 0
        gain = []
        for cost, cashback in transactions:
            if cashback < cost:
                loss += cost - cashback
                gain.append([cost, cashback])
        gain.sort(key=lambda x: x[0], reverse=True)
        max_cost = 0
        if gain:
            max_cost = gain[0][0]
        return loss + max_cost