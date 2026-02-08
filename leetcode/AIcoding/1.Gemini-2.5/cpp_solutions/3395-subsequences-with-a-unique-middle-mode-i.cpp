#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    int subsequencesWithUniqueMiddleModeI(std::vector<int>& nums) {
        int n = nums.size();
        long long count = 0;

        for (int i = 1; i < (1 << n); ++i) {
            std::map<int, int> freq_map;
            int max_freq = 0;

            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    freq_map[nums[j]]++;
                    max_freq = std::max(max_freq, freq_map[nums[j]]);
                }
            }

            int mode_count = 0;
            for (auto const& [val, freq] : freq_map) {
                if (freq == max_freq) {
                    mode_count++;
                }
            }

            if (mode_count == 1) {
                count++;
            }
        }

        return static_cast<int>(count);
    }
};