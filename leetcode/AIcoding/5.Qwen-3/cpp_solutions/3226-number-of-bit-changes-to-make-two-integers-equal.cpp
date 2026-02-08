#include <iostream>
#include <vector>
#include <cmath>

class Solution {
public:
    int minChanges(int n, int k) {
        int count = 0;
        while (n > 0 || k > 0) {
            if ((n & 1) != (k & 1)) {
                count++;
            }
            n >>= 1;
            k >>= 1;
        }
        return count;
    }
};