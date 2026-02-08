class Solution {
public:
    int getMaximumGenerated(int n) {
        if (n == 0) return 0;
        vector<int> nums(n + 1);
        nums[0] = 0;
        nums[1] = 1;
        int max_num = 1;
        for (int i = 2; i <= n; ++i) {
            if (i % 2 == 0) {
                nums[i] = nums[i / 2];
            } else {
                nums[i] = nums[i / 2] + nums[i / 2 + 1];
            }
            max_num = max(max_num, nums[i]);
        }
        return max_num;
    }
};