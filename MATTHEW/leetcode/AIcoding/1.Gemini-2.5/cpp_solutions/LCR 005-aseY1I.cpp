#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int maxProduct(std::vector<std::string>& words) {
        int n = words.size();
        std::vector<int> masks(n);
        std::vector<int> lengths(n);

        for (int i = 0; i < n; ++i) {
            int current_mask = 0;
            for (char c : words[i]) {
                current_mask |= (1 << (c - 'a'));
            }
            masks[i] = current_mask;
            lengths[i] = words[i].length();
        }

        int max_prod = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if ((masks[i] & masks[j]) == 0) { // No common letters
                    max_prod = std::max(max_prod, lengths[i] * lengths[j]);
                }
            }
        }

        return max_prod;
    }
};