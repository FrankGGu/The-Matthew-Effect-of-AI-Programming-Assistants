class Solution {
public:
    int movesToMakeZigzag(vector<int>& nums) {
        int n = nums.size();
        int res1 = 0, res2 = 0;

        for (int i = 0; i < n; ++i) {
            int left = (i > 0) ? nums[i-1] : INT_MAX;
            int right = (i < n-1) ? nums[i+1] : INT_MAX;
            int min_val = min(left, right);

            if (nums[i] >= min_val) {
                if (i % 2 == 0) {
                    res1 += nums[i] - min_val + 1;
                } else {
                    res2 += nums[i] - min_val + 1;
                }
            }
        }

        return min(res1, res2);
    }
};