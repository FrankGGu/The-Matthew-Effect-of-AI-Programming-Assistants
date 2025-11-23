#include <vector>
#include <algorithm>

class Solution {
public:
    int shortestSubarray(std::vector<int>& nums, int k) {
        int n = nums.size();
        int min_len = n + 1;
        int l = 0;
        std::vector<int> bit_counts(32, 0);

        for (int r = 0; r < n; ++r) {
            for (int i = 0; i < 32; ++i) {
                if ((nums[r] >> i) & 1) {
                    bit_counts[i]++;
                }
            }

            while (l <= r) {
                long long current_or = 0;
                for (int i = 0; i < 32; ++i) {
                    if (bit_counts[i] > 0) {
                        current_or |= (1LL << i);
                    }
                }

                if (current_or >= k) {
                    min_len = std::min(min_len, r - l + 1);
                    for (int i = 0; i < 32; ++i) {
                        if ((nums[l] >> i) & 1) {
                            bit_counts[i]--;
                        }
                    }
                    l++;
                } else {
                    break;
                }
            }
        }

        return min_len > n ? -1 : min_len;
    }
};