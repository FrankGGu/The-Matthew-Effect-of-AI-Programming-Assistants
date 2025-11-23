#include <vector>

using namespace std;

class Solution {
public:
    int sumPower(vector<int>& nums) {
        long long ans = 0;
        long long sum = 0;
        int mod = 1e9 + 7;
        sort(nums.begin(), nums.end());
        for (int num : nums) {
            ans = (ans + (long long)num * num % mod * ((sum + num) % mod)) % mod;
            sum = (sum * 2 % mod + num) % mod;
        }
        return ans;
    }
};