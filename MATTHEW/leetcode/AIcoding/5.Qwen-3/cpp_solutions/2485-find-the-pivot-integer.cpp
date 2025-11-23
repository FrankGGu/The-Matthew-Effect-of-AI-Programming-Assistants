#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int pivotInteger(int n) {
        int total = n * (n + 1) / 2;
        int prefix = 0;
        for (int i = 1; i <= n; ++i) {
            prefix += i;
            if (prefix == total - prefix + i) {
                return i;
            }
        }
        return -1;
    }
};