#include <algorithm>
#include <numeric>

class Solution {
public:
    long long lcm(long long x, long long y) {
        if (x == 0 || y == 0) return 0;
        return (x / std::gcd(x, y)) * y;
    }

    int nthMagicalNumber(int n, int a, int b) {
        long long N = n;
        long long A = a;
        long long B = b;
        long long LCM = lcm(A, B);

        long long low = std::min(A, B);
        long long high = 200000000000000LL; // A safe upper bound for the answer (2 * 10^14)

        long long ans = high;

        long long MOD = 1e9 + 7;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            long long count_val = (mid / A) + (mid / B) - (mid / LCM);

            if (count_val >= N) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans % MOD;
    }
};