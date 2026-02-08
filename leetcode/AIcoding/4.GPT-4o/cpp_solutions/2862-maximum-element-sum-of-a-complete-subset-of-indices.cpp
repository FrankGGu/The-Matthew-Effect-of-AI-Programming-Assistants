class Solution {
public:
    int maxSum(const vector<int>& nums) {
        int n = nums.size();
        int max_sum = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int current_sum = 0;
                for (int k = i; k <= j; ++k) {
                    current_sum += nums[k];
                }
                max_sum = max(max_sum, current_sum);
            }
        }
        return max_sum;
    }
};