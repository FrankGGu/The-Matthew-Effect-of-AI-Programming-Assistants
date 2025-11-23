class Solution:
    def maximumWealth(self, accounts: list[list[int]]) -> int:
        max_wealth = 0
        for customer_accounts in accounts:
            current_wealth = sum(customer_accounts)
            if current_wealth > max_wealth:
                max_wealth = current_wealth
        return max_wealth