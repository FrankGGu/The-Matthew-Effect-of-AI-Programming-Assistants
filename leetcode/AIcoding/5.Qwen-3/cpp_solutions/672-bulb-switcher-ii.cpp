#include <iostream>
#include <vector>

class Solution {
public:
    int bulbSwitcherII(int n, int m) {
        if (n == 0 || m == 0) return 0;
        std::vector<int> bulbs(n, 1);
        for (int i = 0; i < m; ++i) {
            for (int j = i; j < n; j += i + 1) {
                bulbs[j] ^= 1;
            }
        }
        int count = 0;
        for (int b : bulbs) {
            count += b;
        }
        return count;
    }
};