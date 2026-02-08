#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxScore(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(1 << n, 0);

        for (int mask = 1; mask < (1 << n); ++mask) {
            int bits = __builtin_popcount(mask);
            if (bits % 2 == 0) continue;

            int pairCount = (bits + 1) / 2;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    for (int j = i + 1; j < n; ++j) {
                        if (mask & (1 << j)) {
                            int newMask = mask ^ (1 << i) ^ (1 << j);
                            dp[mask] = max(dp[mask], dp[newMask] + pairCount * gcd(nums[i], nums[j]));
                        }
                    }
                }
            }
        }

        return dp[(1 << n) - 1];
    }

private:
    int gcd(int a, int b) {
        if (b == 0) return a;
        return gcd(b, a % b);
    }
};