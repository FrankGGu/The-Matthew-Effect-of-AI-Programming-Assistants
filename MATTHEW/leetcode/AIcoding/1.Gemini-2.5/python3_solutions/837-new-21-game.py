class Solution:
    def new21Game(self, N: int, K: int, maxPts: int) -> float:
        if K == 0:
            return 1.0

        # If N is large enough that Alice is guaranteed to win if she reaches any score < K.
        # The maximum score Alice can get by drawing one more card when her score is K-1 is K-1 + maxPts.
        # If this maximum possible score is <= N, then any score she gets from K-1 will be a winning score.
        # Since she starts at 0 and must reach K or more, she will inevitably pass through some score < K (if K>0).
        # The probability of reaching *some* score < K is 1.0 (she starts at 0).
        # So, if N >= K - 1 + maxPts, she wins with probability 1.0.
        if N >= K + maxPts - 1:
            return 1.0

        dp = [0.0] * (N + 1)
        dp[0] = 1.0

        # s is the sum of probabilities dp[j] for j in [i-maxPts, i-1] where j < K.
        # These are the scores from which Alice can still draw a card.
        s = 1.0 

        ans = 0.0

        for i in range(1, N + 1):
            dp[i] = s / maxPts

            # If Alice's current score i is K or more, she stops drawing cards.
            # If her score is also <= N, she wins.
            if i >= K:
                ans += dp[i]

            # If Alice's current score i is less than K, she can draw again.
            # So, dp[i] contributes to the sum 's' for future calculations (as a possible starting point for a new draw).
            if i < K:
                s += dp[i]

            # Remove dp[i - maxPts] from the window sum 's' if it falls out of the sliding window.
            # This is only relevant if dp[i - maxPts] was a score from which Alice could draw (i.e., i - maxPts < K).
            # If i - maxPts >= K, then dp[i - maxPts] would not have been added to 's' in the first place.
            if i - maxPts >= 0 and i - maxPts < K:
                s -= dp[i - maxPts]

        return ans