#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> decodeXOR(std::vector<int>& encoded, int first) {
        int n = encoded.size() + 1;
        std::vector<int> result(n);
        result[0] = first;
        for (int i = 1; i < n; ++i) {
            result[i] = result[i - 1] ^ encoded[i - 1];
        }
        return result;
    }
};