#include <vector>
#include <map>
#include <algorithm>
#include <functional>

class Solution {
public:
    int minSetSize(std::vector<int>& arr) {
        std::map<int, int> freq_map;
        for (int x : arr) {
            freq_map[x]++;
        }

        std::vector<int> frequencies;
        for (auto const& [key, val] : freq_map) {
            frequencies.push_back(val);
        }

        std::sort(frequencies.begin(), frequencies.end(), std::greater<int>());

        int n = arr.size();
        int half_n = n / 2;
        int removed_count = 0;
        int sets_count = 0;

        for (int freq : frequencies) {
            removed_count += freq;
            sets_count++;
            if (removed_count >= half_n) {
                break;
            }
        }

        return sets_count;
    }
};