class Solution {
public:
    int purchasePlans(vector<int>& nums, int target) {
        sort(nums.begin(), nums.end());
        int left = 0, right = nums.size() - 1;
        long long res = 0;
        while (left < right) {
            if (nums[left] + nums[right] > target) {
                right--;
            } else {
                res += right - left;
                left++;
            }
        }
        return res % 1000000007;
    }
};