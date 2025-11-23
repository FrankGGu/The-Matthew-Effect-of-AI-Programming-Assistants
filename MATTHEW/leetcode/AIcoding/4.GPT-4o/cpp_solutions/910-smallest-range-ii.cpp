class Solution {
public:
    int smallestRangeII(vector<int>& nums, int k) {
        int n = nums.size();
        if (n == 1) return 0;

        int minNum = *min_element(nums.begin(), nums.end());
        int maxNum = *max_element(nums.begin(), nums.end());

        int res = maxNum - minNum;

        for (int i = 0; i < n; ++i) {
            int curMin = min(minNum + k, nums[i] + k);
            int curMax = max(maxNum - k, nums[i] - k);
            res = min(res, curMax - curMin);
        }

        return res;
    }
};