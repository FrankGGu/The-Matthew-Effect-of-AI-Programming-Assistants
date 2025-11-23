class Solution {
public:
    int minOperations(vector<int>& nums) {
        int res = 0;
        int max_len = 0;
        for (int num : nums) {
            int bits = 0;
            while (num > 0) {
                res += num & 1;
                num >>= 1;
                bits++;
            }
            max_len = max(max_len, bits);
        }
        if (max_len > 0) {
            res += max_len - 1;
        }
        return res;
    }
};