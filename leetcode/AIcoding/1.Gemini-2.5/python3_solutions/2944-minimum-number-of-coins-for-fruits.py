class Solution:
    def minimumCoins(self, prices: list[int]) -> int:
        n = len(prices)

        # dp[i] represents the minimum cost to acquire all fruits from index i to n-1.
        # We need to find dp[0].
        # Base case: if i >= n, no fruits left to buy, cost is 0.
        # When buying fruit i, we get fruits up to 2*i+2 for free.
        # The next fruit we might need to buy is 2*i+3.
        # For i = n-1, the maximum index accessed will be 2*(n-1)+3 = 2n+1.
        # So, the dp array needs to be of size at least 2n+2.

        # Initialize dp array with 0s. Any index k >= n will naturally be 0,
        # representing no cost for fruits beyond the array bounds.
        dp = [0] * (2 * n + 2) 

        # Iterate backwards from n-1 down to 0
        for i in range(n - 1, -1, -1):
            # To acquire fruit i (and all subsequent fruits up to n-1),
            # we must buy fruit i, as it is the first fruit in the remaining range [i, n-1]
            # that needs to be acquired.
            # The cost is prices[i].
            # When fruit i is bought, fruits from i+1 to 2*i+2 are received for free.
            # Therefore, the next fruit we need to ensure is acquired is at index 2*i+3.
            # The total minimum cost for dp[i] is prices[i] plus the minimum cost
            # to acquire fruits from 2*i+3 onwards (which is dp[2*i+3]).
            dp[i] = prices[i] + dp[2 * i + 3]

        return dp[0]