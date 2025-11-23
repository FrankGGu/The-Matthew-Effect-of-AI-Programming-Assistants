class Solution {
    public int firstDayBeenInAllRooms(int[] nextVisit) {
        int n = nextVisit.length;
        long MOD = 1_000_000_007;

        // dp[i] represents the first day we arrive at room i.
        // We start in room 0 on day 0. So, dp[0] = 0.
        long[] dp = new long[n];
        dp[0] = 0;

        // Iterate from room 1 to n-1
        for (int i = 1; i < n; i++) {
            // To arrive at room i for the first time:
            // 1. We must have arrived at room i-1 for the first time. This happens on day dp[i-1].
            //    At this point, room i-1 has been visited an odd number of times.
            // 2. From room i-1 (odd visit), we go to nextVisit[i-1]. This takes 1 day.
            //    The current day is dp[i-1] + 1. We are now in room nextVisit[i-1].
            // 3. From nextVisit[i-1], we need to return to room i-1.
            //    The number of days to go from nextVisit[i-1] back to room i-1,
            //    and make room i-1 visited an even number of times, is:
            //    (dp[i-1] - dp[nextVisit[i-1]] + MOD) % MOD.
            //    This represents the time elapsed from arriving at nextVisit[i-1] for the first time,
            //    to arriving at i-1 for the second time.
            // 4. After these days, we are back in room i-1, and it has been visited an even number of times.
            // 5. From room i-1 (even visit), we go to room (i-1 + 1) % n = i. This takes 1 day.
            // This is the day we arrive at room i for the first time.

            long daysToReturnToPrevRoomAndMakeEven = (dp[i-1] - dp[nextVisit[i-1]] + MOD) % MOD;
            dp[i] = (dp[i-1] + 1 + daysToReturnToPrevRoomAndMakeEven + 1) % MOD;
        }

        // The problem asks for the first day where we have been in all rooms.
        // When we first arrive at room n-1 (on day dp[n-1]), all rooms from 0 to n-1 have been visited.
        // This is the first day all rooms have been visited.
        return (int) dp[n-1];
    }
}