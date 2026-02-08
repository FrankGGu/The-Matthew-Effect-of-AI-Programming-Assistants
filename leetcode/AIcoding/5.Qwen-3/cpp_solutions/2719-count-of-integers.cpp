#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    int countOfIntegers(int n) {
        if (n == 0) return 0;
        long long result = 0;
        for (int i = 1; i <= n; ++i) {
            long long count = 9 * pow(10, i - 1);
            result += count;
        }
        return static_cast<int>(result);
    }
};