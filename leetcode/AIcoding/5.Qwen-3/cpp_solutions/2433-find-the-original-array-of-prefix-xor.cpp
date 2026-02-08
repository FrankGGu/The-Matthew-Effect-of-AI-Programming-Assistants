#include <vector>

class Solution {
public:
    std::vector<int> findOriginalArray(std::vector<int>& prefix) {
        int n = prefix.size();
        std::vector<int> original(n);
        original[0] = prefix[0];
        for (int i = 1; i < n; ++i) {
            original[i] = prefix[i] ^ prefix[i - 1];
        }
        return original;
    }
};