#include <vector>

class Solution {
public:
    std::vector<int> sumZero(int n) {
        std::vector<int> result(n);
        int sum = 0;
        for (int i = 0; i < n - 1; ++i) {
            result[i] = i;
            sum += i;
        }
        result[n - 1] = -sum;
        return result;
    }
};