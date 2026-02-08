#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int maxNiceDivisors(int n) {
        const int MOD = 1e9 + 7;
        if (n == 1) return 1;
        if (n == 2) return 2;
        if (n == 3) return 3;

        long long result = 1;
        long long remainder = n % 4;
        long long quotient = n / 4;

        if (remainder == 0) {
            result = pow(4, quotient);
        } else if (remainder == 1) {
            result = pow(4, quotient - 1) * 3;
        } else if (remainder == 2) {
            result = pow(4, quotient) * 2;
        } else if (remainder == 3) {
            result = pow(4, quotient) * 3;
        }

        return static_cast<int>(result % MOD);
    }
};