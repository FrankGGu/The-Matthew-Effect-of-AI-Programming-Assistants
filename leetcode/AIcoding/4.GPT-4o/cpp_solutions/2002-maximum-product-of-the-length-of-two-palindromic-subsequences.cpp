#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int maxProduct(std::vector<std::string>& words) {
        int n = words.size();
        std::vector<int> masks(n);

        for (int i = 0; i < n; ++i) {
            for (char c : words[i]) {
                masks[i] |= (1 << (c - 'a'));
            }
        }

        int maxProd = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if ((masks[i] & masks[j]) == 0) {
                    maxProd = std::max(maxProd, (int)words[i].size() * (int)words[j].size());
                }
            }
        }

        return maxProd;
    }
};