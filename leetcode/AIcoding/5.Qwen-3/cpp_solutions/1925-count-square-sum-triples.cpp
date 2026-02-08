#include <iostream>
#include <vector>
#include <cmath>

class Solution {
public:
    int countTriples(int n) {
        int count = 0;
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= n; ++j) {
                int sum = i * i + j * j;
                int k = static_cast<int>(sqrt(sum));
                if (k * k == sum && k <= n) {
                    ++count;
                }
            }
        }
        return count;
    }
};