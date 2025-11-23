#include <vector>
#include <queue>
#include <algorithm>

class Solution {
public:
    int maximumProduct(std::vector<int>& nums, int k) {
        std::priority_queue<int, std::vector<int>, std::greater<int>> minHeap(nums.begin(), nums.end());
        while (k--) {
            int smallest = minHeap.top();
            minHeap.pop();
            minHeap.push(smallest + 1);
        }
        long long product = 1;
        const int MOD = 1e9 + 7;
        while (!minHeap.empty()) {
            product = (product * minHeap.top()) % MOD;
            minHeap.pop();
        }
        return product;
    }
};