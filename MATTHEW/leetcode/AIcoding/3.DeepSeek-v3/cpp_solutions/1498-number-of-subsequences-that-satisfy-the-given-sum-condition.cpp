class Solution {
public:
    int numSubseq(vector<int>& nums, int target) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int mod = 1e9 + 7;
        vector<int> pow2(n + 1, 1);
        for (int i = 1; i <= n; ++i) {
            pow2[i] = (pow2[i - 1] * 2) % mod;
        }

        int left = 0, right = n - 1;
        int res = 0;
        while (left <= right) {
            if (nums[left] + nums[right] > target) {
                --right;
            } else {
                res = (res + pow2[right - left]) % mod;
                ++left;
            }
        }
        return res;
    }
};