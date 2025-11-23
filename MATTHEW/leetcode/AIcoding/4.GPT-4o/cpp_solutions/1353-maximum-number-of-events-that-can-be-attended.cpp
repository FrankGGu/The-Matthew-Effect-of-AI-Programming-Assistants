#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int maxEvents(vector<vector<int>>& events) {
        sort(events.begin(), events.end());
        priority_queue<int, vector<int>, greater<int>> minHeap;
        int day = 0, count = 0, i = 0, n = events.size();

        while (day < 100001) {
            while (i < n && events[i][0] == day) {
                minHeap.push(events[i][1]);
                i++;
            }
            while (!minHeap.empty() && minHeap.top() < day) {
                minHeap.pop();
            }
            if (!minHeap.empty()) {
                minHeap.pop();
                count++;
            }
            day++;
        }
        return count;
    }
};