class Solution {
public:
    vector<int> fillMissingData(vector<int>& nums) {
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            if (nums[i] == -1) {
                int left = i > 0 ? nums[i - 1] : 0;
                int right = i < n - 1 ? nums[i + 1] : 0;
                nums[i] = (left + right) / 2;
            }
        }
        return nums;
    }
};