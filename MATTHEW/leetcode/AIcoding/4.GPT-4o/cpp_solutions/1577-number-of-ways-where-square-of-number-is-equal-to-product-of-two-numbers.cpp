class Solution {
public:
    int numOfWays(int a, int b) {
        long long aSquare = (long long)a * a;
        long long bSquare = (long long)b * b;
        int count = 0;

        for (long long x = 1; x * x <= aSquare; ++x) {
            if (aSquare % x == 0) {
                long long y = aSquare / x;
                if (y != x && y <= bSquare) {
                    count++;
                }
            }
        }

        for (long long x = 1; x * x <= bSquare; ++x) {
            if (bSquare % x == 0) {
                long long y = bSquare / x;
                if (y != x && y <= aSquare) {
                    count++;
                }
            }
        }

        return count;
    }
};