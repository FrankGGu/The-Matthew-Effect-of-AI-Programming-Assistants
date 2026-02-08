#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> sumZero(int n) {
        std::vector<int> result;
        result.reserve(n);

        for (int i = 1; i <= n / 2; ++i) {
            result.push_back(i);
            result.push_back(-i);
        }

        if (n % 2 == 1) {
            result.push_back(0);
        }

        return result;
    }
};