#include <vector>
#include <queue>
#include <functional>

class Solution {
public:
    int maximumProduct(std::vector<int>& nums, int k) {
        std::priority_queue<long long, std::vector<long long>, std::greater<long long>> min_heap;

        for (int num : nums) {
            min_heap.push(num);
        }

        for (int i = 0; i < k; ++i) {
            long long current_min = min_heap.top();
            min_heap.pop();
            min_heap.push(current_min + 1);
        }

        long long product = 1;
        long long MOD = 1e9 + 7;

        while (!min_heap.empty()) {
            product = (product * min_heap.top()) % MOD;
            min_heap.pop();
        }

        return static_cast<int>(product);
    }
};