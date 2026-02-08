#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumProduct(vector<int>& nums, int k) {
        priority_queue<int, vector<int>, greater<int>> minHeap(nums.begin(), nums.end());

        while (k > 0) {
            int smallest = minHeap.top();
            minHeap.pop();
            minHeap.push(smallest + 1);
            k--;
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