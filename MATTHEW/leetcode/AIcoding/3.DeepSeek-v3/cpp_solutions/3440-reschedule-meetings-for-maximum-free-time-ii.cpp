#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int maxFreeTime(vector<vector<int>>& schedule) {
        sort(schedule.begin(), schedule.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] < b[0];
        });

        priority_queue<int, vector<int>, greater<int>> minHeap;
        int maxGap = 0;

        for (const auto& interval : schedule) {
            if (!minHeap.empty() && interval[0] > minHeap.top()) {
                maxGap = max(maxGap, interval[0] - minHeap.top());
            }
            minHeap.push(interval[1]);
        }

        return maxGap;
    }
};