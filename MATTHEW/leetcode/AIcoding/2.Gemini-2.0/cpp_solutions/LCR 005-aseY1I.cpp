#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int maxProduct(vector<string>& words) {
        int n = words.size();
        vector<int> mask(n, 0);
        for (int i = 0; i < n; ++i) {
            for (char c : words[i]) {
                mask[i] |= (1 << (c - 'a'));
            }
        }

        int max_product = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if ((mask[i] & mask[j]) == 0) {
                    max_product = max(max_product, (int)(words[i].length() * words[j].length()));
                }
            }
        }
        return max_product;
    }
};