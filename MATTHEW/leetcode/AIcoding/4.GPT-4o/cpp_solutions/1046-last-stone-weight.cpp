#include <vector>
#include <queue>

class Solution {
public:
    int lastStoneWeight(std::vector<int>& stones) {
        std::priority_queue<int> maxHeap(stones.begin(), stones.end());
        while (maxHeap.size() > 1) {
            int stone1 = maxHeap.top();
            maxHeap.pop();
            int stone2 = maxHeap.top();
            maxHeap.pop();
            if (stone1 != stone2) {
                maxHeap.push(stone1 - stone2);
            }
        }
        return maxHeap.empty() ? 0 : maxHeap.top();
    }
};