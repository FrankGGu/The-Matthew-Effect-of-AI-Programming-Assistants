#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canPartitionKSubsets(vector<int>& nums, int k) {
        int total = 0;
        for (int num : nums) {
            total += num;
        }
        if (total % k != 0) {
            return false;
        }
        int target = total / k;
        sort(nums.begin(), nums.end(), greater<int>());
        vector<bool> used(nums.size(), false);

        function<bool(int, int, int)> backtrack = [&](int start, int count, int currentSum) -> bool {
            if (count == k) {
                return true;
            }
            if (currentSum == target) {
                return backtrack(0, count + 1, 0);
            }
            for (int i = start; i < nums.size(); ++i) {
                if (!used[i] && currentSum + nums[i] <= target) {
                    used[i] = true;
                    if (backtrack(i + 1, count, currentSum + nums[i])) {
                        return true;
                    }
                    used[i] = false;
                }
            }
            return false;
        };

        return backtrack(0, 0, 0);
    }
};