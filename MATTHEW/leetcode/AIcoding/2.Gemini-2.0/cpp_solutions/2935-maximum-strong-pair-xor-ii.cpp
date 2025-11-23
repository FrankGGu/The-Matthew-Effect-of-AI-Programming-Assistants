class Solution {
public:
    int maximumStrongPairXor(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                if (nums[j] <= 2 * nums[i]) {
                    ans = max(ans, nums[i] ^ nums[j]);
                } else {
                    break;
                }
            }
        }
        return ans;
    }
};