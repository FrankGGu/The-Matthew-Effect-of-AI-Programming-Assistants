class Solution:
    def firstDayBeenInAllRooms(self, nextVisit: list[int]) -> int:
        n = len(nextVisit)
        MOD = 10**9 + 7

        # dp[i] stores the day we first arrive at room i.
        # We start in room 0 on day 0.
        # The definition of "day" is crucial: Day X is the day a move occurs and we arrive at a room.
        # So, on day 0, we are in room 0.
        # On day 1, we make the first move.

        # dp[i] = the day we first arrive at room i.
        # Base case:
        # We are at room 0 on day 0. So, dp[0] = 0.
        dp = [0] * n

        # For i from 1 to n-1:
        # To calculate dp[i] (the day we first arrive at room i):
        # 1. We must have first arrived at room i-1. This happened on day dp[i-1].
        #    At this point (day dp[i-1]), we are in room i-1 for the first time.
        #    Its visit count is 1 (odd).
        # 2. From room i-1 (odd visits), we move to nextVisit[i-1]. This takes 1 day.
        #    So, on day (dp[i-1] + 1), we arrive at room nextVisit[i-1].
        # 3. From room nextVisit[i-1], we need to eventually return to room i-1
        #    such that room i-1 has been visited an even number of times.
        #    The number of days it takes to go from room nextVisit[i-1] (having visited it
        #    an even number of times) to room i-1 (having visited it an even number of times)
        #    is given by the difference dp[i-1] - dp[nextVisit[i-1]].
        #    This is because dp[k] represents the day we first arrive at room k,
        #    which implies rooms 0 to k-1 have been visited an even number of times.
        #    So, (dp[i-1] - dp[nextVisit[i-1]]) is the time elapsed to traverse the segment
        #    from nextVisit[i-1] to i-1, ensuring all intermediate rooms are visited an even number of times.
        #    Therefore, the day we arrive at room i-1 for the second time (even visits) is:
        #    (Day we arrived at i-1 for 1st time) + (1 day to move to nextVisit[i-1]) + (days to go from nextVisit[i-1] (even) to i-1 (even))
        #    = dp[i-1] + 1 + (dp[i-1] - dp[nextVisit[i-1]])
        #    = 2 * dp[i-1] - dp[nextVisit[i-1]] + 1.
        #    Let's call this `day_i_minus_1_second_visit`.
        # 4. On `day_i_minus_1_second_visit`, we are in room i-1, and its visit count is even.
        #    According to the rules, we then move to room (i-1 + 1) % n, which is room i.
        #    This move takes 1 day.
        #    So, the day we first arrive at room i (dp[i]) is `day_i_minus_1_second_visit` + 1.
        #    dp[i] = (2 * dp[i-1] - dp[nextVisit[i-1]] + 1) + 1
        #    dp[i] = (2 * dp[i-1] - dp[nextVisit[i-1]] + 2) % MOD

        for i in range(1, n):
            # The term (2 * dp[i-1] - dp[nextVisit[i-1]] + 2) is guaranteed to be positive.
            # This is because dp[k] is non-decreasing with k, and nextVisit[i-1] <= i-1.
            # Thus, dp[nextVisit[i-1]] <= dp[i-1].
            # So, 2 * dp[i-1] - dp[nextVisit[i-1]] + 2 >= 2 * dp[i-1] - dp[i-1] + 2 = dp[i-1] + 2.
            # Since dp[i-1] >= 0, the expression is always >= 2.
            # Therefore, a simple modulo operation in Python handles this correctly.
            dp[i] = (2 * dp[i-1] - dp[nextVisit[i-1]] + 2) % MOD

        # The problem asks for the first day where we have visited all rooms.
        # dp[n-1] represents the day we first arrive at room n-1.
        # By this point, all rooms from 0 to n-1 must have been visited at least once.
        # Thus, dp[n-1] is the answer.
        return dp[n-1]