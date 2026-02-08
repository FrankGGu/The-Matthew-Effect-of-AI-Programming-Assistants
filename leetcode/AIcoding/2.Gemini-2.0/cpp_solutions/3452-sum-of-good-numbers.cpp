#include <vector>

using namespace std;

class Solution {
public:
    int countGoodNumbers(long long n) {
        long long odd = n / 2;
        long long even = n - odd;
        long long mod = 1e9 + 7;
        long long a = 1;
        long long b = 1;

        long long baseA = 5;
        while (even > 0) {
            if (even % 2 == 1) {
                a = (a * baseA) % mod;
            }
            baseA = (baseA * baseA) % mod;
            even /= 2;
        }

        long long baseB = 4;
        while (odd > 0) {
            if (odd % 2 == 1) {
                b = (b * baseB) % mod;
            }
            baseB = (baseB * baseB) % mod;
            odd /= 2;
        }

        return (a * b) % mod;
    }
};