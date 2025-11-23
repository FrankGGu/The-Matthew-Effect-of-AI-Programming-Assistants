class Solution {
public:
    int sumOfGoodSubsequences(vector<int>& nums) {
        long long mod = 1e9 + 7;
        long long total = 0, currentSum = 0, powerOfTwo = 1;

        sort(nums.begin(), nums.end());

        for (int num : nums) {
            currentSum = (currentSum + num * powerOfTwo) % mod;
            total = (total + currentSum) % mod;
            powerOfTwo = (powerOfTwo * 2) % mod;
        }

        return total;
    }
};