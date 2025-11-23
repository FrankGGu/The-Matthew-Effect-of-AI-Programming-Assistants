class Solution {
public:
    int nthUglyNumber(int n, int a, int b, int c) {
        auto lcm = [](int x, int y) {
            return x / __gcd(x, y) * y;
        };
        auto count = [&](long long x) {
            return x / a + x / b + x / c - x / lcm(a, b) - x / lcm(a, c) - x / lcm(b, c) + x / lcm(lcm(a, b), c);
        };

        long long left = 1, right = 2e9;
        while (left < right) {
            long long mid = left + (right - left) / 2;
            if (count(mid) < n) left = mid + 1;
            else right = mid;
        }
        return left;
    }
};