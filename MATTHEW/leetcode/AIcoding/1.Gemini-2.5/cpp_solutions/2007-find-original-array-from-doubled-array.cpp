#include <vector>
#include <map>

class Solution {
public:
    std::vector<int> findOriginalArray(std::vector<int>& changed) {
        if (changed.size() % 2 != 0) {
            return {};
        }

        std::map<int, int> counts;
        for (int x : changed) {
            counts[x]++;
        }

        std::vector<int> original;

        for (auto const& [val, freq] : counts) {
            if (freq == 0) {
                continue;
            }

            if (val == 0) {
                if (freq % 2 != 0) {
                    return {};
                }
                for (int i = 0; i < freq / 2; ++i) {
                    original.push_back(0);
                }
                counts[val] = 0;
            } else { // val > 0
                int doubled_val = val * 2;
                if (counts.count(doubled_val) == 0 || counts[doubled_val] < freq) {
                    return {};
                }

                for (int i = 0; i < freq; ++i) {
                    original.push_back(val);
                }
                counts[doubled_val] -= freq;
                counts[val] = 0;
            }
        }

        return original;
    }
};