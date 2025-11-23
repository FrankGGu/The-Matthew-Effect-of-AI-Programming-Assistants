#include <iostream>
#include <vector>
#include <cmath>

class Solution {
public:
    int countGoodNumbers(long long n) {
        const int MOD = 1e9 + 7;
        long long even = pow(5, n / 2 + n % 2);
        long long odd = pow(4, n / 2);
        return (even * odd) % MOD;
    }
};