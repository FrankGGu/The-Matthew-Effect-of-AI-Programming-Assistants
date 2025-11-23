class Solution {
public:
    int minimizeOR(vector<int>& nums, int k) {
        int result = 0;
        for (int num : nums) {
            result |= num;
        }
        for (int i = 0; i < 32; ++i) {
            if (k & (1 << i)) {
                result ^= (1 << i);
            }
        }
        return result;
    }
};