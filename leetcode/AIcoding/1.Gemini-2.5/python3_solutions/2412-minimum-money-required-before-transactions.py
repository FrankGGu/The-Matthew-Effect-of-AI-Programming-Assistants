class Solution:
    def minimumMoney(self, transactions: list[list[int]]) -> int:
        good_transactions = []
        bad_transactions = []

        for cost, cashback in transactions:
            if cashback >= cost:
                good_transactions.append((cost, cashback))
            else:
                bad_transactions.append((cost, cashback))

        # Sort good transactions by cost ascending
        good_transactions.sort(key=lambda x: x[0])

        # Sort bad transactions by cashback descending
        bad_transactions.sort(key=lambda x: x[1], reverse=True)

        sorted_transactions = good_transactions + bad_transactions

        ans = 0
        current_money = 0

        for cost, cashback in sorted_transactions:
            if current_money < cost:
                ans += (cost - current_money)
                current_money = cost

            current_money -= cost
            current_money += cashback

        return ans