#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int sumOfPower(vector<int>& nums) {
        long long mod = 1e9 + 7;
        sort(nums.begin(), nums.end());
        long long ans = 0;
        long long sum = 0;
        for (int num : nums) {
            ans = (ans + (long long)num * num % mod * (num + sum)) % mod;
            sum = (sum * 2 + num) % mod;
        }
        return ans;
    }
};