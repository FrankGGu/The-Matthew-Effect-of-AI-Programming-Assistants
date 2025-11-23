class Solution {
public:
    int findUnsortedSubarray(vector<int>& nums) {
        int n = nums.size();
        int start = 0, end = -1;
        int max_num = nums[0];
        int min_num = nums[n - 1];

        for (int i = 1; i < n; ++i) {
            if (nums[i] < max_num) {
                end = i;
            } else {
                max_num = nums[i];
            }
        }

        for (int i = n - 2; i >= 0; --i) {
            if (nums[i] > min_num) {
                start = i;
            } else {
                min_num = nums[i];
            }
        }

        return end - start + 1;
    }
};