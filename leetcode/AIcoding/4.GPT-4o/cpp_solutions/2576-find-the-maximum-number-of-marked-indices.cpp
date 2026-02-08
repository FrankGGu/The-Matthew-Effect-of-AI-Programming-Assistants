class Solution {
public:
    int maxNumMarkedIndices(vector<int>& nums) {
        int n = nums.size();
        sort(nums.begin(), nums.end());
        int count = 0;
        for (int i = 0; i < n / 2; ++i) {
            if (nums[i] * 2 <= nums[n - 1 - i]) {
                count += 2;
            }
        }
        if (n % 2 == 1) count++;
        return count;
    }
};