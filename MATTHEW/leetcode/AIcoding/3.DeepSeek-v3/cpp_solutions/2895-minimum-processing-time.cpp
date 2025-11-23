#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minProcessingTime(vector<int>& processorTime, vector<int>& tasks) {
        sort(processorTime.begin(), processorTime.end());
        sort(tasks.begin(), tasks.end(), greater<int>());

        int maxTime = 0;
        int n = processorTime.size();
        for (int i = 0; i < n; ++i) {
            int currentMax = processorTime[i] + tasks[4 * i];
            if (currentMax > maxTime) {
                maxTime = currentMax;
            }
        }
        return maxTime;
    }
};