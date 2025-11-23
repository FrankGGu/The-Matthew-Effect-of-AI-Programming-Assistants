class Solution {
public:
    int subsetXORSum(vector<int>& nums) {
        int total = 0, n = nums.size();
        for (int mask = 0; mask < (1 << n); ++mask) {
            int xorSum = 0;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    xorSum ^= nums[i];
                }
            }
            total += xorSum;
        }
        return total;
    }
};