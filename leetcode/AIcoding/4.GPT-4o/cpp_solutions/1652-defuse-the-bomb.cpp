#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> decrypt(std::vector<int>& code, int k) {
        int n = code.size();
        std::vector<int> result(n, 0);

        if (k == 0) return result;

        int start = (k > 0) ? 1 : n + k;
        int end = (k > 0) ? k : n - 1;

        for (int i = start; i <= end; ++i) {
            result[(i - 1) % n] += code[i % n];
        }

        return result;
    }
};