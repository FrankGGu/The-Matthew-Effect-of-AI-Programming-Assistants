#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int minNonZeroProduct(int k) {
        long long mod = 1000000007;
        long long max_val = (1LL << k) - 1;
        long long count = (1LL << (k - 1)) - 1;
        long long result = 1;

        for (long long i = 0; i < count; ++i) {
            result = (result * ((max_val - i) % mod)) % mod;
        }

        return static_cast<int>(result % mod);
    }
};