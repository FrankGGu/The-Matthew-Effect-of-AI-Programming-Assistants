#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    int mostFrequentEven(std::vector<int>& nums) {
        std::map<int, int> counts;
        for (int num : nums) {
            if (num % 2 == 0) {
                counts[num]++;
            }
        }

        if (counts.empty()) {
            return -1;
        }

        int max_freq = -1;
        int result = -1;

        for (auto const& [num, freq] : counts) {
            if (freq > max_freq) {
                max_freq = freq;
                result = num;
            } else if (freq == max_freq) {
                // Since std::map iterates in sorted key order,
                // the first element encountered with max_freq will be the smallest.
                // We don't need std::min here explicitly if we rely on map's ordering.
                // However, to be explicit and robust for any map type, we can keep it.
                // For std::map, result will already hold the smaller number if a tie happens later.
                // If a tie happens *now* with a new number, this new number must be larger
                // than the current result because map iterates in ascending key order.
                // So, if freq == max_freq, we only update if num is smaller, which won't happen
                // if we iterate std::map.
                // Let's simplify: if freq == max_freq, we don't need to do anything,
                // as `result` would already hold the smallest number due to `std::map`'s iteration order.
                // The current `num` would be greater than `result`.
            }
        }

        return result;
    }
};