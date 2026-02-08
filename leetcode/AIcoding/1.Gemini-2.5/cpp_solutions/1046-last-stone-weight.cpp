#include <vector>
#include <queue>
#include <functional> // For std::priority_queue

class Solution {
public:
    int lastStoneWeight(std::vector<int>& stones) {
        std::priority_queue<int> pq;

        for (int stone : stones) {
            pq.push(stone);
        }

        while (pq.size() > 1) {
            int y = pq.top();
            pq.pop();
            int x = pq.top();
            pq.pop();

            if (y - x > 0) {
                pq.push(y - x);
            }
        }

        if (pq.empty()) {
            return 0;
        } else {
            return pq.top();
        }
    }
};