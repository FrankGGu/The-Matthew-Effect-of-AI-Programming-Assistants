#include <vector>
#include <string>

class Solution {
public:
    std::vector<bool> canMakePaliQueries(std::string s, std::vector<std::vector<int>>& queries) {
        int n = s.length();
        std::vector<int> prefix_xor_masks(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefix_xor_masks[i + 1] = prefix_xor_masks[i] ^ (1 << (s[i] - 'a'));
        }

        std::vector<bool> results;
        results.reserve(queries.size());

        for (const auto& query : queries) {
            int left = query[0];
            int right = query[1];
            int k = query[2];

            int current_mask = prefix_xor_masks[right + 1] ^ prefix_xor_masks[left];

            int odd_counts = __builtin_popcount(current_mask);

            if (odd_counts / 2 <= k) {
                results.push_back(true);
            } else {
                results.push_back(false);
            }
        }

        return results;
    }
};