#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minProcessingTime(vector<int>& processingTime, vector<int>& tasks) {
        sort(processingTime.begin(), processingTime.end());
        sort(tasks.rbegin(), tasks.rend());

        int n = processingTime.size();
        int m = tasks.size();
        int maxTime = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < 4; ++j) {
                maxTime = max(maxTime, processingTime[i] + tasks[i * 4 + j]);
            }
        }

        return maxTime;
    }
};