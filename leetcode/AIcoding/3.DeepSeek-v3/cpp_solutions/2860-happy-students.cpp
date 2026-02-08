class Solution {
public:
    int countWays(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int res = 0;
        if (nums[0] > 0) res++;
        for (int i = 0; i < n - 1; ++i) {
            if (nums[i] < i + 1 && nums[i + 1] > i + 1) {
                res++;
            }
        }
        if (nums.back() < n) res++;
        return res;
    }
};