#include <vector>
#include <queue>
#include <numeric>

class Solution {
public:
    int minStoneSum(std::vector<int>& piles, int k) {
        std::priority_queue<int> maxHeap(piles.begin(), piles.end());
        while (k--) {
            int top = maxHeap.top();
            maxHeap.pop();
            maxHeap.push(top - top / 2);
        }
        return std::accumulate(piles.begin(), piles.end(), 0) - std::accumulate(piles.begin(), piles.end(), 0, [&](int sum, int pile) {
            return sum + pile / 2;
        });
    }
};