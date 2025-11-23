#include <vector>

using namespace std;

class Solution {
public:
    int completeDay(vector<int>& leaveTimes) {
        int n = leaveTimes.size();
        int max_time = leaveTimes[0];
        for (int i = 1; i < n; ++i) {
            max_time = max(max_time, leaveTimes[i] - leaveTimes[i - 1]);
        }
        return max_time;
    }
};