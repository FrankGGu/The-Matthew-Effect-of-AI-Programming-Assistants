class Solution {
public:
    int nthMagicalNumber(int n, int a, int b) {
        const int MOD = 1e9 + 7;
        long long lcm_ab = lcm(a, b);
        long long left = 0, right = (long long)n * min(a, b);

        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long count = mid / a + mid / b - mid / lcm_ab;
            if (count < n) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left % MOD;
    }

private:
    long long gcd(long long a, long long b) {
        while (b != 0) {
            long long temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    long long lcm(long long a, long long b) {
        return a / gcd(a, b) * b;
    }
};