class Solution {
public:
    int preimageSizeFZF(int K) {
        long left = 0, right = 5L * (K + 1);
        while (left <= right) {
            long mid = left + (right - left) / 2;
            long zeros = trailingZeroes(mid);
            if (zeros == K) {
                return 5;
            } else if (zeros < K) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return 0;
    }

private:
    long trailingZeroes(long n) {
        long count = 0;
        while (n > 0) {
            count += n / 5;
            n /= 5;
        }
        return count;
    }
};