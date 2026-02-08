#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int sumOfPower(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        long long ans = 0;
        long long sum = 0;
        long long mod = 1e9 + 7;

        for (int num : nums) {
            ans = (ans + (long long)num * num % mod * (num + sum) % mod) % mod;
            sum = (sum * 2 % mod + num) % mod;
        }

        return ans;
    }
};