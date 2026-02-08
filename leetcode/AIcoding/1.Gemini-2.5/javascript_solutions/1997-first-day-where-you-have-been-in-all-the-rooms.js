var firstDayBeenInAllRooms = function(nextVisit) {
    const n = nextVisit.length;
    const MOD = 10 ** 9 + 7;

    // dp[i] represents the day we first visit room i.
    // We are interested in the day we first visit room n-1.
    // The problem asks for the first day where you have been in ALL the rooms.
    // This means we need to reach room n-1 for the first time.
    // So, the answer will be dp[n-1].
    const dp = new Array(n).fill(0);

    // Base case: We start at room 0 on day 0.
    // So, the day we first visit room 0 is 0.
    dp[0] = 0;

    // Iterate from room 1 to n-1
    for (let i = 1; i < n; i++) {
        // To reach room i for the first time, we must have visited room i-1 for the second time.
        //
        // Let's trace the path from the first visit to room i-1 to the first visit to room i:
        // 1. We are at room i-1 for the first time on day dp[i-1].
        //    (This is an odd visit count for room i-1).
        //    According to the rule, we go to (i-1 + 1) % n = i.
        //    BUT, this is only if we visit room i-1 an ODD number of times.
        //    We need to visit room i-1 for the SECOND time (even count) to go to nextVisit[i-1].
        //    And then we need to visit room i-1 for the THIRD time (odd count) to go to room i.
        //
        // Let's redefine dp[i] as the day we first visit room i+1.
        // So, dp[i] is the day we transition from room i to room i+1.
        // The answer will be dp[n-1].
        //
        // To calculate dp[i] (day we first visit room i+1):
        // We are at room i for the first time on day dp[i-1]. (If i > 0, dp[-1] = 0 for room 0).
        // 1. From room i (1st visit, day dp[i-1]), we go to nextVisit[i]. This takes 1 day.
        //    So, on day (dp[i-1] + 1), we are at room nextVisit[i].
        // 2. Now we need to return to room i for its second visit.
        //    The number of days to go from room nextVisit[i] (on day dp[i-1] + 1) to room i (2nd visit) is:
        //    (dp[i-1] - dp[nextVisit[i]]) days.
        //    This is because dp[i-1] is the day we first visit room i.
        //    dp[nextVisit[i]] is the day we first visit room nextVisit[i]+1.
        //    The difference (dp[i-1] - dp[nextVisit[i]]) represents the number of days it takes to traverse
        //    the segment from room nextVisit[i]+1 to room i, visiting each room in between for the second time.
        //    So, the day we visit room i for the second time is:
        //    (dp[i-1] + 1) + (dp[i-1] - dp[nextVisit[i]])
        // 3. After visiting room i for the second time, we go to room (i+1)%n. This takes 1 more day.
        //    So, dp[i] = ((dp[i-1] + 1) + (dp[i-1] - dp[nextVisit[i]]) + 1) % MOD.
        //    dp[i] = (2 * dp[i-1] - dp[nextVisit[i]] + 2) % MOD.
        //
        // Note: The `nextVisit` array is 0-indexed, and `nextVisit[i]` refers to the next room from `i`.
        // So, `dp[nextVisit[i]]` refers to the day we first visit `nextVisit[i]+1`.
        // This means `dp[nextVisit[i]]` is a previously computed value since `nextVisit[i] <= i`.
        //
        // Let's adjust for `i=0` case for `dp[nextVisit[i]]`.
        // If `nextVisit[i] == 0`, then `dp[nextVisit[i]]` is `dp[0]`.
        // `dp[0]` is the day we first visit room 1.
        //
        // Let's use `dp[i]` as the day we first visit room `i`.
        // `dp[0] = 0` (Day 0, room 0).
        // For `i = 1` to `n-1`:
        // To first visit room `i`, we must have visited room `i-1` for the second time.
        // The day we first visit room `i-1` is `dp[i-1]`.
        // From room `i-1` (1st visit, day `dp[i-1]`), we go to `nextVisit[i-1]`. This takes 1 day.
        // So, on day `dp[i-1] + 1`, we are at room `nextVisit[i-1]`.
        // Now we need to get back to room `i-1` for its second visit.
        // The number of days to go from `nextVisit[i-1]` (on day `dp[i-1] + 1`) to room `i-1` (2nd visit) is:
        // `dp[i-1]` (day we first visit room `i-1`) - `dp[nextVisit[i-1]]` (day we first visit room `nextVisit[i-1]`).
        // This difference is the number of days to traverse the segment from `nextVisit[i-1]` to `i-1`, visiting each room in between for the second time.
        // So, the day we visit room `i-1` for the second time is:
        // `(dp[i-1] + 1) + (dp[i-1] - dp[nextVisit[i-1]])`.
        // After visiting room `i-1` for the second time, we go to room `i`. This takes 1 more day.
        // So, `dp[i] = ((dp[i-1] + 1) + (dp[i-1] - dp[nextVisit[i-1]]) + 1) % MOD`.
        // `dp[i] = (2 * dp[i-1] - dp[nextVisit[i-1]] + 2) % MOD`.
        // We add `MOD` before taking modulo to handle negative results from subtraction.

        let days = (2 * dp[i - 1] - dp[nextVisit[i - 1]] + 2 + MOD) % MOD;
        dp[i] = days;
    }

    // The answer is the day we first visit room n-1.
    // After visiting room n-1, we have visited all rooms.
    return dp[n - 1];
};