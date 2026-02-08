#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumFinishTime(vector<vector<int>>& tires, int changeTime, int numLaps) {
        vector<int> minTime(numLaps + 1, INT_MAX);
        minTime[0] = 0;

        for (int i = 0; i < tires.size(); ++i) {
            int f = tires[i][0];
            int r = tires[i][1];
            long long time = 0;
            long long totalTime = 0;
            for (int j = 1; j <= numLaps; ++j) {
                time = f * pow(r, j - 1);
                totalTime += time;
                if (totalTime > 1e9 || totalTime > minTime.back() + changeTime) break;
                if (totalTime >= INT_MAX) break;
                minTime[j] = min(minTime[j], (int)totalTime);
                if (time > 1e9 / r) break;
                if (time == 0) break;
            }
        }

        for (int i = 1; i <= numLaps; ++i) {
            for (int j = 1; j < i; ++j) {
                if (minTime[i - j] != INT_MAX && minTime[j] != INT_MAX) {
                    minTime[i] = min(minTime[i], minTime[i - j] + changeTime + minTime[j]);
                }
            }
        }

        return minTime[numLaps];
    }
};