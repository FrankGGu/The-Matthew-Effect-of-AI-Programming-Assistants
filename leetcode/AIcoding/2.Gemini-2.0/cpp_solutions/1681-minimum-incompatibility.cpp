#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minimumIncompatibility(vector<int>& nums, int k) {
        int n = nums.size();
        int groupSize = n / k;
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
            if (count[num] > 1) return -1;
        }

        vector<int> dp(1 << n, -1);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            if (dp[mask] == -1) continue;
            if (__builtin_popcount(mask) % groupSize == 0) {
                vector<int> available;
                for (int i = 0; i < n; ++i) {
                    if (!(mask & (1 << i))) {
                        available.push_back(i);
                    }
                }

                if (available.empty()) continue;

                vector<int> subset(groupSize);
                function<void(int, int, int)> solve = 
                    [&](int index, int start, int submask) {
                    if (index == groupSize) {
                        vector<int> currentSubset;
                        int newMask = mask;
                        for (int i = 0; i < n; ++i) {
                            if (submask & (1 << i)) {
                                newMask |= (1 << i);
                                currentSubset.push_back(nums[i]);
                            }
                        }

                        unordered_map<int, int> subsetCount;
                        for (int num : currentSubset) {
                            subsetCount[num]++;
                            if (subsetCount[num] > 1) return;
                        }

                        int minVal = *min_element(currentSubset.begin(), currentSubset.end());
                        int maxVal = *max_element(currentSubset.begin(), currentSubset.end());

                        int incompatibility = maxVal - minVal;

                        if (dp[newMask] == -1 || dp[newMask] > dp[mask] + incompatibility) {
                            dp[newMask] = dp[mask] + incompatibility;
                        }
                        return;
                    }

                    for (int i = start; i < available.size(); ++i) {
                        solve(index + 1, i + 1, submask | (1 << available[i]));
                    }
                };

                solve(0, 0, 0);
            }
        }

        return dp[(1 << n) - 1];
    }
};