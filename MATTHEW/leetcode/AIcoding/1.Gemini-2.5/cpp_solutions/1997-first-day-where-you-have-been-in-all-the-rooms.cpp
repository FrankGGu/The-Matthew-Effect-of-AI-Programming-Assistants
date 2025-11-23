#include <vector>

class Solution {
public:
    int firstDayBeenInAllRooms(std::vector<int>& nextVisit) {
        int n = nextVisit.size();
        long long MOD = 1e9 + 7;

        if (n == 1) {
            return 0;
        }

        // dp[i] stores the day we visit room i for the second time.
        // Day 0 is the first day.
        std::vector<long long> dp(n);

        // Base case: dp[0]
        // Day 0: Arrive at Room 0 (1st visit).
        // Problem constraint: nextVisit[i] <= i, so nextVisit[0] must be 0.
        // On Day 0, we are in Room 0 (1st visit, odd count). We move to nextVisit[0] (which is 0).
        // Day 1: Arrive at Room 0 (2nd visit).
        // So, Room 0 is visited for the second time on Day 1.
        dp[0] = 1;

        // For i from 1 to n-1:
        // To visit room i for the second time:
        // 1. We must have visited room i-1 for the second time. This happens on day dp[i-1].
        // 2. On day dp[i-1], we are in room i-1 (2nd visit, even count). We move to (i-1 + 1) % n = i.
        // 3. On day dp[i-1] + 1, we are in room i (1st visit).
        // 4. Since it's an odd visit, we move to nextVisit[i]. (1 day passes).
        // 5. On day dp[i-1] + 2, we are in room nextVisit[i].
        // 6. From room nextVisit[i], we need to return to room i for its second visit.
        //    The number of days to go from room nextVisit[i] (after its first visit)
        //    to room i (for its second visit) is:
        //    This duration is equivalent to the time elapsed from when room nextVisit[i] was visited
        //    for the second time (dp[nextVisit[i]]) to when room i-1 was visited for the second time (dp[i-1]).
        //    So, it takes (dp[i-1] - dp[nextVisit[i]]) days.
        //    Therefore, dp[i] = (day we arrive at i for 1st time) + (1 day to move to nextVisit[i]) + (days to return from nextVisit[i] to i for 2nd visit).
        //    dp[i] = (dp[i-1] + 1) + 1 + (dp[i-1] - dp[nextVisit[i]])
        //    dp[i] = (2 * dp[i-1] - dp[nextVisit[i]] + 2)

        for (int i = 1; i < n; ++i) {
            long long prev_room_dp = dp[i-1]; // Day room i-1 was visited for the second time.
            long long target_room_dp = dp[nextVisit[i]]; // Day nextVisit[i] was visited for the second time.

            dp[i] = (2LL * prev_room_dp - target_room_dp + 2 + MOD) % MOD;
        }

        // The problem asks for the first day where you have been in all rooms.
        // This means we need to visit room n-1 at least once.
        // The day we have visited all rooms is the day we first visit room n-1.
        // The value dp[n-1] represents the day room n-1 is visited for the second time.
        // The first visit to room n-1 happens exactly 1 day before the second visit,
        // after moving from room n-2 (2nd visit) to room n-1 (1st visit).
        // So, the first day we visit room n-1 is dp[n-1] - 1.
        return (dp[n-1] - 1 + MOD) % MOD;
    }
};