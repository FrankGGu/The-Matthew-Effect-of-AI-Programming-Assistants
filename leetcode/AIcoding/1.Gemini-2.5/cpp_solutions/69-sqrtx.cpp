class Solution {
public:
    int mySqrt(int x) {
        if (x == 0) {
            return 0;
        }

        long long low = 1;
        long long high = x;
        long long ans = 0;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            long long square = mid * mid;

            if (square == x) {
                return mid;
            } else if (square < x) {
                ans = mid;
                low = mid + 1;
            } else { // square > x
                high = mid - 1;
            }
        }
        return (int)ans;
    }
};