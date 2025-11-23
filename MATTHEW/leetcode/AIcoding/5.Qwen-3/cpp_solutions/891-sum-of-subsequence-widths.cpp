#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int sumSubseqWidths(int n, vector<int>& nums) {
        sort(nums.begin(), nums.end());
        long long result = 0;
        long long mod = 1e9 + 7;
        vector<long long> pow2(n, 1);
        for (int i = 1; i < n; ++i) {
            pow2[i] = (pow2[i - 1] * 2) % mod;
        }
        for (int i = 0; i < n; ++i) {
            result = (result + (nums[i] * (pow2[i] - 1)) % mod) % mod;
            result = (result - (nums[i] * (pow2[n - i - 1] - 1)) % mod + mod) % mod;
        }
        return static_cast<int>(result);
    }
};