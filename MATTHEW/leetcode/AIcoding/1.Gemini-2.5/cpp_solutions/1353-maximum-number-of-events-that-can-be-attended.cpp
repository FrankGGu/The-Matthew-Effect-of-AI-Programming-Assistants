#include <vector>
#include <algorithm>
#include <queue>

class Solution {
public:
    int maxEvents(std::vector<std::vector<int>>& events) {
        std::sort(events.begin(), events.end());

        std::priority_queue<int, std::vector<int>, std::greater<int>> pq;
        int count = 0;
        int i = 0;
        int n = events.size();

        for (int d = 1; d <= 100000; ++d) {
            while (!pq.empty() && pq.top() < d) {
                pq.pop();
            }

            while (i < n && events[i][0] == d) {
                pq.push(events[i][1]);
                i++;
            }

            if (!pq.empty()) {
                pq.pop();
                count++;
            }

            if (i >= n && pq.empty()) {
                break;
            }
        }

        return count;
    }
};