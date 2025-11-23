class Solution {
public:
    int countNicePairs(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        unordered_map<int, int> freq;
        int res = 0;
        for (int num : nums) {
            int rev = 0, n = num;
            while (n > 0) {
                rev = rev * 10 + n % 10;
                n /= 10;
            }
            int diff = num - rev;
            res = (res + freq[diff]) % MOD;
            freq[diff]++;
        }
        return res;
    }
};