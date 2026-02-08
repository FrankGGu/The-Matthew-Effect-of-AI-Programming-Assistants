#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int minimumOneBitOperations(int n) {
        if (n == 0) return 0;
        int a = 0;
        while ((1 << a) <= n) ++a;
        --a;
        return (1 << a) - minimumOneBitOperations((1 << a) - 1 - n);
    }
};