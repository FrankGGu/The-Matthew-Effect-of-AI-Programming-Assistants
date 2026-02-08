#include <vector>
#include <numeric>

class Solution {
public:
    bool canWin(std::vector<int>& x, std::vector<int>& y) {
        int nim_sum = 0;
        for (size_t i = 0; i < x.size(); ++i) {
            nim_sum ^= (x[i] + y[i]);
        }
        return nim_sum != 0;
    }
};