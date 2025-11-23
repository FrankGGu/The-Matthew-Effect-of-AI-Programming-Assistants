#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumXorProduct(long long a, long long b, int n) {
        long long mod = 1e9 + 7;
        long long x = 0;

        for (int i = n - 1; i >= 0; --i) {
            long long mask = 1LL << i;
            if (((a & mask) == (b & mask))) {
                if (a < b) {
                    a ^= mask;
                } else {
                    b ^= mask;
                }
            }
        }

        return (a % mod) * (b % mod) % mod;
    }
};