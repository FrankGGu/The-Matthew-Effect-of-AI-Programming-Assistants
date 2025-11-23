class Solution:
    def coinChange(self, coins: list[int], amount: int) -> int:
        if amount == 0:
            return 0

        # dp[i] will be the minimum number of coins to make up amount i
        # Initialize dp array with a value indicating infinity (amount + 1 is a safe upper bound)
        dp = [amount + 1] * (amount + 1)

        # Base case: 0 coins needed for amount 0
        dp[0] = 0

        # Iterate through each amount from 1 to 'amount'
        for i in range(1, amount + 1):
            # For each amount, iterate through all available coins
            for coin in coins:
                # If the current coin can be used to form the current amount i
                if i - coin >= 0:
                    # Update dp[i] with the minimum of its current value
                    # and (dp[i - coin] + 1) which represents using one 'coin'
                    # plus the minimum coins needed for the remaining amount (i - coin)
                    dp[i] = min(dp[i], dp[i - coin] + 1)

        # If dp[amount] is still (amount + 1), it means the amount cannot be made up
        return dp[amount] if dp[amount] <= amount else -1