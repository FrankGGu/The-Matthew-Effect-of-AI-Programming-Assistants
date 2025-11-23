class Solution {
public:
    int nthUglyNumber(int n, int a, int b, int c) {
        long long low = 1, high = 2e9;
        long long lcmAB = lcm(a, b);
        long long lcmAC = lcm(a, c);
        long long lcmBC = lcm(b, c);
        long long lcmABC = lcm(lcmAB, c);

        while (low < high) {
            long long mid = low + (high - low) / 2;
            long long count = mid / a + mid / b + mid / c - mid / lcmAB - mid / lcmAC - mid / lcmBC + mid / lcmABC;
            if (count < n) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

private:
    long long gcd(long long a, long long b) {
        if (b == 0) return a;
        return gcd(b, a % b);
    }

    long long lcm(long long a, long long b) {
        return a * b / gcd(a, b);
    }
};