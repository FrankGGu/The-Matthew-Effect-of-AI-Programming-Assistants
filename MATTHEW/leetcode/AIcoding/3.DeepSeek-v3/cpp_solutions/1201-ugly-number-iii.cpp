class Solution {
public:
    int nthUglyNumber(int n, int a, int b, int c) {
        long long ab = lcm(a, b);
        long long ac = lcm(a, c);
        long long bc = lcm(b, c);
        long long abc = lcm(ab, c);

        long long left = 1, right = 2 * 1e18;
        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long count = mid / a + mid / b + mid / c - mid / ab - mid / ac - mid / bc + mid / abc;
            if (count < n) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

private:
    long long gcd(long long a, long long b) {
        return b == 0 ? a : gcd(b, a % b);
    }

    long long lcm(long long a, long long b) {
        return a * b / gcd(a, b);
    }
};