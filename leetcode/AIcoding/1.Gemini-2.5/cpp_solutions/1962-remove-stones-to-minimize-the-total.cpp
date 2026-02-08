#include <vector>
#include <queue>
#include <numeric>

class Solution {
public:
    int minStoneSum(std::vector<int>& piles, int k) {
        std::priority_queue<int> max_heap(piles.begin(), piles.end());

        for (int i = 0; i < k; ++i) {
            int current_max = max_heap.top();
            max_heap.pop();
            max_heap.push(current_max - current_max / 2);
        }

        int total_sum = 0;
        while (!max_heap.empty()) {
            total_sum += max_heap.top();
            max_heap.pop();
        }

        return total_sum;
    }
};