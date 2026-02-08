#include <vector>
#include <map>
#include <algorithm> // For std::max

class Solution {
public:
    int minLengthAfterRemovals(std::vector<int>& nums) {
        int n = nums.size();

        std::map<int, int> counts;
        for (int x : nums) {
            counts[x]++;
        }

        int max_freq = 0;
        for (auto const& pair : counts) {
            max_freq = std::max(max_freq, pair.second);
        }

        if (max_freq > n / 2) {
            return 2 * max_freq - n;
        } else {
            return n % 2;
        }
    }
};