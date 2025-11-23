#include <vector>

using namespace std;

class Solution {
public:
    int sumOfGoodSubsequences(vector<int>& nums) {
        long long mod = 1e9 + 7;
        long long ans = 0;
        long long powerOfTwo = 1;
        int countZero = 0;

        for (int num : nums) {
            if (num == 0) {
                countZero++;
            } else {
                ans = (ans + num) % mod;
            }
        }

        if (nums.size() > countZero) {
            for (int i = 0; i < nums.size() - countZero - 1; ++i) {
                powerOfTwo = (powerOfTwo * 2) % mod;
            }
            ans = (ans * powerOfTwo) % mod;
            powerOfTwo = 1;
            for (int i = 0; i < countZero; ++i) {
                powerOfTwo = (powerOfTwo * 2) % mod;
            }
            ans = (ans + powerOfTwo - 1 + mod) % mod;
        } else {
            powerOfTwo = 1;
            for (int i = 0; i < countZero; ++i) {
                powerOfTwo = (powerOfTwo * 2) % mod;
            }
            ans = (powerOfTwo - 1 + mod) % mod;
        }

        return (int)ans;
    }
};