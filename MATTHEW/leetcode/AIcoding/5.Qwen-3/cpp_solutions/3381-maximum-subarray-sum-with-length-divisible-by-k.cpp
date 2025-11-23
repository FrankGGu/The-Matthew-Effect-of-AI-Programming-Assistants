#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int maxSubarraySum(int k, vector<int>& nums) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        long long maxSum = INT_MIN;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                if ((j - i) % k == 0) {
                    long long currentSum = prefix[j] - prefix[i];
                    if (currentSum > maxSum) {
                        maxSum = currentSum;
                    }
                }
            }
        }

        return maxSum;
    }
};