#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minProcessingTime(vector<int>& processorTime, vector<int>& tasks) {
        sort(processorTime.begin(), processorTime.end());
        sort(tasks.rbegin(), tasks.rend());

        int n = processorTime.size();
        int m = tasks.size();
        int res = 0;

        for (int i = 0; i < n; ++i) {
            int max_time = processorTime[i] + tasks[i * 4];
            res = max(res, max_time);
        }

        return res;
    }
};