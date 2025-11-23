class Solution {
public:
    int nthMagicalNumber(int n, int a, int b) {
        long long low = min(a, b);
        long long high = (long long)n * min(a, b);
        long long lcm = (long long)a * b / std::gcd(a, b);
        long long ans = 0;
        while (low <= high) {
            long long mid = low + (high - low) / 2;
            long long count = mid / a + mid / b - mid / lcm;
            if (count >= n) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans % 1000000007;
    }
};