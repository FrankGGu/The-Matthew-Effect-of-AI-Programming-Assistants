#include <algorithm>

class Solution {
public:
    int fillCups(vector<int>& amount) {
        std::sort(amount.begin(), amount.end());
        int a = amount[0], b = amount[1], c = amount[2];
        if (a + b <= c) {
            return c;
        } else {
            return (a + b + c + 1) / 2;
        }
    }
};