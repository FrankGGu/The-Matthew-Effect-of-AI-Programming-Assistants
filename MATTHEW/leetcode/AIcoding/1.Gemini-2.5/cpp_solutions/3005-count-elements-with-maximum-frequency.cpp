#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    int maxFrequencyElements(std::vector<int>& nums) {
        std::map<int, int> frequencies;
        for (int num : nums) {
            frequencies[num]++;
        }

        int max_freq = 0;
        for (auto const& [num, freq] : frequencies) {
            if (freq > max_freq) {
                max_freq = freq;
            }
        }

        int total_elements_with_max_freq = 0;
        for (auto const& [num, freq] : frequencies) {
            if (freq == max_freq) {
                total_elements_with_max_freq += freq;
            }
        }

        return total_elements_with_max_freq;
    }
};