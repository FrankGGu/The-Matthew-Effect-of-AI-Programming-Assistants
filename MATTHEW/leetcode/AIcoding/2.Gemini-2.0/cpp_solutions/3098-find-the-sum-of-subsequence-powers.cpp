#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int sumOfPower(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        long long sum = 0;
        long long mod = 1e9 + 7;
        long long prefixSum = 0;
        for (int i = 0; i < nums.size(); i++) {
            sum = (sum + (long long)nums[i] * nums[i] % mod * (nums[i] + prefixSum) % mod) % mod;
            prefixSum = (prefixSum * 2 % mod + nums[i]) % mod;
        }
        return sum;
    }
};