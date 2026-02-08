class Solution {
public:
    int minimumFinishTime(vector<vector<int>>& tires, int changeTime, int numLaps) {
        const int INF = 1e9;
        vector<int> minTime(20, INF);
        for (auto &tire : tires) {
            int f = tire[0];
            int r = tire[1];
            int total = 0;
            for (int lap = 1; lap <= 19; ++lap) {
                int cost = f * pow(r, lap - 1);
                if (cost > changeTime + f) {
                    break;
                }
                total += cost;
                if (total < minTime[lap]) {
                    minTime[lap] = total;
                }
            }
        }

        vector<int> dp(numLaps + 1, INF);
        dp[0] = 0;
        for (int i = 1; i <= numLaps; ++i) {
            for (int j = 1; j <= min(19, i); ++j) {
                if (minTime[j] == INF) continue;
                dp[i] = min(dp[i], dp[i - j] + minTime[j] + (i - j == 0 ? 0 : changeTime));
            }
        }
        return dp[numLaps] - changeTime;
    }
};