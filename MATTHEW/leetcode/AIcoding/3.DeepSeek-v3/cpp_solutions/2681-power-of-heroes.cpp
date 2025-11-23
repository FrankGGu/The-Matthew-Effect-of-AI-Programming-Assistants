class Solution {
public:
    int sumOfPower(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        sort(nums.begin(), nums.end());
        long long res = 0, sum = 0;
        for (long long num : nums) {
            res = (res + num * num % MOD * num % MOD + num * num % MOD * sum % MOD) % MOD;
            sum = (sum * 2 + num) % MOD;
        }
        return res;
    }
};