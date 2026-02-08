#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minIntegerBreak(int n) {
        if (n == 1) return 0;
        int minChairs = 0;
        int current = 1;
        while (current <= n) {
            minChairs++;
            current += minChairs;
        }
        return minChairs - 1;
    }
};