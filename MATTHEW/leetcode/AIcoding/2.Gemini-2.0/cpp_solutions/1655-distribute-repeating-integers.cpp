#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canDistribute(vector<int>& nums, vector<int>& quantity) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        vector<int> freq;
        for (auto const& [key, val] : count) {
            freq.push_back(val);
        }

        sort(quantity.rbegin(), quantity.rend());

        int n = quantity.size();
        vector<int> dp(1 << n, 0);
        dp[0] = 1;

        for (int f : freq) {
            for (int mask = (1 << n) - 1; mask >= 0; --mask) {
                if (dp[mask]) {
                    for (int submask = 0; submask < (1 << n); ++submask) {
                        if ((mask & submask) == 0) {
                            int sum = 0;
                            bool possible = true;
                            for (int i = 0; i < n; ++i) {
                                if ((submask & (1 << i)) != 0) {
                                    sum += quantity[i];
                                }
                            }
                            if (sum <= f) {
                                dp[mask | submask] = 1;
                            }
                        }
                    }
                }
            }
        }

        return dp[(1 << n) - 1];
    }
};