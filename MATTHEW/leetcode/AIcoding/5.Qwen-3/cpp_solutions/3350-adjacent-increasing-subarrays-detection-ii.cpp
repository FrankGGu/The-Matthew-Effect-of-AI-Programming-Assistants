#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool isAdjacentIncreasing(const vector<int>& nums, int k) {
        for (int i = 0; i + k <= nums.size(); ++i) {
            bool flag = true;
            for (int j = 0; j < k - 1; ++j) {
                if (nums[i + j] >= nums[i + j + 1]) {
                    flag = false;
                    break;
                }
            }
            if (flag) return true;
        }
        return false;
    }

    bool checkSubarraySum(const vector<int>& nums, int k) {
        vector<int> prefixSum(nums.size() + 1, 0);
        for (int i = 0; i < nums.size(); ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j <= nums.size(); ++j) {
                if ((prefixSum[j] - prefixSum[i]) % k == 0) {
                    return true;
                }
            }
        }
        return false;
    }

    bool adjacentIncreasingSubarraysDetectionII(const vector<int>& nums, int k) {
        for (int i = 0; i + 2 * k <= nums.size(); ++i) {
            if (isAdjacentIncreasing(nums, k)) {
                return true;
            }
        }
        return false;
    }
};