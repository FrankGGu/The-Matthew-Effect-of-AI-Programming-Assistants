#include <vector>

using namespace std;

class Solution {
public:
    int temperatureTrend(vector<int>& temperatureA, vector<int>& temperatureB) {
        int n = temperatureA.size();
        int max_len = 0;
        int curr_len = 0;
        if (n <= 1) return 0;

        for (int i = 0; i < n - 1; ++i) {
            int diffA = temperatureA[i + 1] - temperatureA[i];
            int diffB = temperatureB[i + 1] - temperatureB[i];

            int trendA = (diffA > 0) ? 1 : ((diffA < 0) ? -1 : 0);
            int trendB = (diffB > 0) ? 1 : ((diffB < 0) ? -1 : 0);

            if (trendA == trendB) {
                curr_len++;
            } else {
                max_len = max(max_len, curr_len);
                curr_len = 0;
            }
        }

        max_len = max(max_len, curr_len);

        return max_len;
    }
};