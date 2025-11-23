class Solution {
public:
    int mod = 1e9 + 7;

    int sumOfPower(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        long long res = 0, sum = 0, power = 0;

        for (int num : nums) {
            power = (power * 2 + 1) % mod;
            sum = (sum * 2 + num) % mod;
            res = (res + num * power) % mod;
        }

        return res;
    }
};