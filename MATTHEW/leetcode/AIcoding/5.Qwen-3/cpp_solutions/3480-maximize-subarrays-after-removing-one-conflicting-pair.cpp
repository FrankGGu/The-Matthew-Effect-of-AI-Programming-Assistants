#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxSubarrays(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> prefixSum;
        prefixSum[0] = -1;
        int sum = 0;
        int result = 0;
        for (int i = 0; i < n; ++i) {
            sum += nums[i];
            if (prefixSum.find(sum) != prefixSum.end()) {
                result++;
                prefixSum.clear();
                prefixSum[0] = i;
                sum = 0;
            } else {
                prefixSum[sum] = i;
            }
        }
        return result;
    }
};