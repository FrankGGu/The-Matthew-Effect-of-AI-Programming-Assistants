class Solution {
public:
    long long sumOfPowers(vector<int>& nums, int k) {
        long long sum = 0;
        int n = nums.size();
        for (int i = 0; i <= n - k; ++i) {
            int min_val = nums[i];
            for (int j = i; j < i + k; ++j) {
                if (nums[j] < min_val) {
                    min_val = nums[j];
                }
            }
            sum += min_val;
        }
        return sum;
    }
};