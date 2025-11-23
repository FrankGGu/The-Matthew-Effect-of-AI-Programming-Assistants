class Solution {
public:
    int subsetXORSum(vector<int>& nums) {
        int sum = 0;
        int n = nums.size();
        for (int i = 0; i < (1 << n); ++i) {
            int xor_sum = 0;
            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    xor_sum ^= nums[j];
                }
            }
            sum += xor_sum;
        }
        return sum;
    }
};