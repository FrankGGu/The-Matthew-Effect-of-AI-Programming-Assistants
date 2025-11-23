#include <iostream>
#include <vector>
#include <cmath>

class Solution {
public:
    int concatenatedBinary(int n) {
        long long result = 0;
        for (int i = 1; i <= n; i++) {
            int length = static_cast<int>(log2(i)) + 1;
            result = (result << length) | i;
        }
        return static_cast<int>(result);
    }
};