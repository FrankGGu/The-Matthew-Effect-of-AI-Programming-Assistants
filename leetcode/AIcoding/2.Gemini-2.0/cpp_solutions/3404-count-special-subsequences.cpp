class Solution {
public:
    int countSpecialSubsequences(vector<int>& nums) {
        long long mod = 1e9 + 7;
        long long zero = 0, one = 0, two = 0;
        for (int num : nums) {
            if (num == 0) {
                zero = (2 * zero + 1) % mod;
            } else if (num == 1) {
                one = (2 * one + zero) % mod;
            } else {
                two = (2 * two + one) % mod;
            }
        }
        return two;
    }
};