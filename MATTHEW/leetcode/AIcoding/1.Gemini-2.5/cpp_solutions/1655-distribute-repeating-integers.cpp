#include <vector>
#include <map>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::map<std::pair<int, std::map<int, int>>, bool> memo;

    bool canDistribute(std::vector<int>& freq, std::vector<int>& quantity, int customer_idx) {
        if (customer_idx == quantity.size()) {
            return true;
        }

        std::map<int, int> freq_counts_map;
        for (int count_val : freq) {
            if (count_val > 0) {
                freq_counts_map[count_val]++;
            }
        }

        std::pair<int, std::map<int, int>> state = {customer_idx, freq_counts_map};
        if (memo.count(state)) {
            return memo[state];
        }

        int needed = quantity[customer_idx];

        for (int i = 0; i < freq.size(); ++i) {
            if (freq[i] >= needed) {
                freq[i] -= needed;

                if (canDistribute(freq, quantity, customer_idx + 1)) {
                    return memo[state] = true;
                }

                freq[i] += needed;
            }
        }

        return memo[state] = false;
    }

    bool distributeRepeatingIntegers(std::vector<int>& nums, std::vector<int>& quantity) {
        std::map<int, int> counts_map;
        for (int x : nums) {
            counts_map[x]++;
        }

        std::vector<int> freq;
        for (auto const& [val, count] : counts_map) {
            freq.push_back(count);
        }

        std::sort(quantity.rbegin(), quantity.rend());

        return canDistribute(freq, quantity, 0);
    }
};