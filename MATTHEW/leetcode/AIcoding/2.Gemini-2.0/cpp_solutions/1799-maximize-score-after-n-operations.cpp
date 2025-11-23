#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxScore(vector<int>& nums) {
        int n = nums.size();
        vector<vector<int>> gcd_matrix(n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                gcd_matrix[i][j] = gcd(nums[i], nums[j]);
            }
        }

        int m = n / 2;
        vector<int> dp(1 << n, 0);

        for (int mask = 0; mask < (1 << n); ++mask) {
            if (__builtin_popcount(mask) % 2 == 0) {
                int pairs_taken = __builtin_popcount(mask) / 2;
                if (pairs_taken == m) continue;

                for (int i = 0; i < n; ++i) {
                    if (!(mask & (1 << i))) {
                        for (int j = i + 1; j < n; ++j) {
                            if (!(mask & (1 << j))) {
                                int new_mask = mask | (1 << i) | (1 << j);
                                dp[new_mask] = max(dp[new_mask], dp[mask] + (pairs_taken + 1) * gcd_matrix[i][j]);
                            }
                        }
                        break;
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