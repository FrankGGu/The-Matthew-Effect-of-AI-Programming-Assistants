class Solution:
    def superEggDrop(self, K: int, N: int) -> int:
        # dp[k][m] represents the maximum number of floors we can check
        # (or determine the critical floor for) with k eggs and m moves.
        # Our goal is to find the minimum m such that dp[K][m] >= N.

        # Initialize dp table.
        # dp[k][m] where k is the number of eggs and m is the number of moves.
        # The maximum number of moves can be N (e.g., if K=1, we check floors one by one).
        # We need K+1 rows for eggs (0 to K) and N+1 columns for moves (0 to N).
        dp = [[0] * (N + 1) for _ in range(K + 1)]

        # Iterate through the number of moves 'm'.
        # 'm' starts from 1 because 0 moves can check 0 floors.
        # 'm' can go up to N in the worst case.
        for m in range(1, N + 1):
            # Iterate through the number of eggs 'k'.
            # 'k' starts from 1 because 0 eggs can check 0 floors.
            # 'k' goes up to K.
            for k in range(1, K + 1):
                # The recurrence relation for dp[k][m]:
                # If we make a drop at some floor x:
                # 1. The egg breaks: We've used 1 move and 1 egg. We are left with k-1 eggs and m-1 moves.
                #    We can determine the critical floor among dp[k-1][m-1] floors below x.
                # 2. The egg doesn't break: We've used 1 move, but still have k eggs. We are left with k eggs and m-1 moves.
                #    We can determine the critical floor among dp[k][m-1] floors above x.
                # The current floor x itself accounts for 1 floor.
                # So, dp[k][m] = (floors below x) + (floor x) + (floors above x)
                dp[k][m] = dp[k - 1][m - 1] + 1 + dp[k][m - 1]

            # After calculating dp[K][m] for the current 'm',
            # check if we have enough capacity to cover all N floors.
            # If dp[K][m] is greater than or equal to N, then 'm' is the minimum
            # number of moves required.
            if dp[K][m] >= N:
                return m

        # This line should theoretically not be reached for valid inputs (N >= 1),
        # as eventually dp[K][m] will cover N floors (worst case: m=N when K=1).
        return N