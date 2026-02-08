#include <vector>
#include <string>
#include <unordered_set>

class Solution {
public:
    int maxProduct(std::vector<std::string>& words) {
        int n = words.size();
        std::vector<int> bitMask(n, 0);

        for (int i = 0; i < n; ++i) {
            for (char c : words[i]) {
                bitMask[i] |= 1 << (c - 'a');
            }
        }

        int maxProduct = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if ((bitMask[i] & bitMask[j]) == 0) {
                    maxProduct = std::max(maxProduct, (int)words[i].size() * (int)words[j].size());
                }
            }
        }

        return maxProduct;
    }
};