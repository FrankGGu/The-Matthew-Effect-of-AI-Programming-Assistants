class Solution {
public:
    long long countFairPairs(vector<int>& nums, int lower, int upper) {
        sort(nums.begin(), nums.end());
        long long count = 0;
        int n = nums.size();

        for (int i = 0; i < n; i++) {
            int lo = lower_bound(nums.begin() + i + 1, nums.end(), lower - nums[i]) - nums.begin();
            int hi = upper_bound(nums.begin() + i + 1, nums.end(), upper - nums[i]) - nums.begin();
            count += hi - lo;
        }

        return count;
    }
};