#include <iostream>
#include <vector>
#include <bitset>

using namespace std;

class Solution {
public:
    int numSubarraysWithSumK(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        int count = 0;
        vector<int> freq(k + 1, 0);
        for (int i = 0; i <= n; ++i) {
            if (prefixSum[i] >= k) {
                count += freq[prefixSum[i] - k];
            }
            if (prefixSum[i] <= k) {
                ++freq[prefixSum[i]];
            }
        }

        return count;
    }
};