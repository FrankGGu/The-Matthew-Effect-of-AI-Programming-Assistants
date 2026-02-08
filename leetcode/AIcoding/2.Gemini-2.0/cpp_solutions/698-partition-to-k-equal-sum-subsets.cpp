#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    bool canPartitionKSubsets(vector<int>& nums, int k) {
        int sum = accumulate(nums.begin(), nums.end(), 0);
        if (sum % k != 0) return false;
        int target = sum / k;
        int n = nums.size();
        vector<bool> used(n, false);
        sort(nums.rbegin(), nums.rend());

        function<bool(int, int, int)> backtrack = 
            [&](int subsetSum, int count, int start) {
            if (count == k) return true;
            if (subsetSum == target) return backtrack(0, count + 1, 0);

            for (int i = start; i < n; ++i) {
                if (used[i] || subsetSum + nums[i] > target) continue;
                used[i] = true;
                if (backtrack(subsetSum + nums[i], count, i + 1)) return true;
                used[i] = false;
            }
            return false;
        };

        return backtrack(0, 0, 0);
    }
};