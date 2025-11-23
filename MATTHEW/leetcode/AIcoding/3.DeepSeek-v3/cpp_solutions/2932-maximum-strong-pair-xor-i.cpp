class Solution {
public:
    int maximumStrongPairXor(vector<int>& nums) {
        int max_xor = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int x = nums[i];
                int y = nums[j];
                if (abs(x - y) <= min(x, y)) {
                    max_xor = max(max_xor, x ^ y);
                }
            }
        }
        return max_xor;
    }
};