#include <vector>

class Solution {
public:
    std::vector<int> sumOfThree(int num) {
        if (num % 3 == 0) {
            return {num / 3 - 1, num / 3, num / 3 + 1};
        }
        return {};
    }
};