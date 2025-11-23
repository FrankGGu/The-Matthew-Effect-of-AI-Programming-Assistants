class Solution {
public:
    int numSubseq(vector<int>& nums, int target) {
        sort(nums.begin(), nums.end());
        int mod = 1e9 + 7;
        int n = nums.size();
        vector<int> power(n + 1, 1);
        for (int i = 1; i <= n; ++i) {
            power[i] = (power[i - 1] * 2) % mod;
        }

        int left = 0, right = n - 1, count = 0;
        while (left <= right) {
            if (nums[left] + nums[right] <= target) {
                count = (count + power[right - left]) % mod;
                left++;
            } else {
                right--;
            }
        }
        return count;
    }
};