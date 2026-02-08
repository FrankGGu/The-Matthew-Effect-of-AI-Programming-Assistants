#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int rangeSum(vector<int>& nums, int n, int k) {
        const int MOD = 1000000007;
        priority_queue<long long, vector<long long>, greater<long long>> minHeap;

        for (int i = 0; i < n; ++i) {
            long long sum = nums[i];
            minHeap.push(sum);
            for (int j = i + 1; j < n; ++j) {
                sum += nums[j];
                minHeap.push(sum);
            }
        }

        long long result = 0;
        for (int i = 0; i < k; ++i) {
            result = (result + minHeap.top()) % MOD;
            minHeap.pop();
        }

        return static_cast<int>(result);
    }
};