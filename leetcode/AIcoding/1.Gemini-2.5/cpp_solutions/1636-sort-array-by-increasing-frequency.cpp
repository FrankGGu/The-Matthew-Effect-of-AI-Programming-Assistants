#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    std::vector<int> frequencySort(std::vector<int>& nums) {
        std::map<int, int> freq_map;
        for (int num : nums) {
            freq_map[num]++;
        }

        std::sort(nums.begin(), nums.end(), [&](int a, int b) {
            if (freq_map[a] != freq_map[b]) {
                return freq_map[a] < freq_map[b];
            }
            return a > b;
        });

        return nums;
    }
};