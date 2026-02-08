#include <vector>
#include <algorithm>

class Solution {
public:
    int temperatureTrend(std::vector<int>& temperatureA, std::vector<int>& temperatureB) {
        int n = temperatureA.size();

        int max_streak = 0;
        int current_streak = 0;

        for (int i = 0; i < n - 1; ++i) {
            int trendA_i;
            if (temperatureA[i+1] > temperatureA[i]) {
                trendA_i = 1;
            } else if (temperatureA[i+1] < temperatureA[i]) {
                trendA_i = -1;
            } else {
                trendA_i = 0;
            }

            int trendB_i;
            if (temperatureB[i+1] > temperatureB[i]) {
                trendB_i = 1;
            } else if (temperatureB[i+1] < temperatureB[i]) {
                trendB_i = -1;
            } else {
                trendB_i = 0;
            }

            if (trendA_i == trendB_i) {
                current_streak++;
            } else {
                current_streak = 0;
            }
            max_streak = std::max(max_streak, current_streak);
        }

        return max_streak;
    }
};