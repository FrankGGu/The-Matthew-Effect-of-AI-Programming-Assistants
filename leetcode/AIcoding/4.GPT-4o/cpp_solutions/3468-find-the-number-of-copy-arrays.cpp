class Solution {
public:
    int countCopyArrays(vector<int>& nums) {
        int n = nums.size();
        sort(nums.begin(), nums.end());
        long long count = 1, mod = 1e9 + 7;
        for (int i = 1; i < n; ++i) {
            if (nums[i] != nums[i - 1]) {
                count = count * 2 % mod;
            }
        }
        return count;
    }
};