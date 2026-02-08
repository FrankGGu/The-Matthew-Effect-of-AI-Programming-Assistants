#include <vector>
#include <unordered_map>
#include <unordered_set>

class Solution {
public:
    int findPairs(std::vector<int>& nums, int k) {
        if (k < 0) {
            return 0;
        }

        std::unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int count = 0;
        if (k == 0) {
            for (auto const& [num, f] : freq) {
                if (f > 1) {
                    count++;
                }
            }
        } else {
            for (auto const& [num, f] : freq) {
                if (freq.count(num + k)) {
                    count++;
                }
            }
        }
        return count;
    }
};