#include <vector>
#include <unordered_map>
#include <algorithm> // Required for std::max

class Solution {
public:
    int minimumOperations(std::vector<int>& nums, int k) {
        if (k == 0) {
            return 0;
        }

        int n = nums.size();

        std::unordered_map<int, int> freq_map;
        int max_freq = 0;

        for (int x : nums) {
            freq_map[x]++;
            if (freq_map[x] > max_freq) {
                max_freq = freq_map[x];
            }
        }

        return n - max_freq;
    }
};