class Solution {
public:
    long long trailingZeroes(long long n) {
        long long count = 0;
        while (n >= 5) {
            n /= 5;
            count += n;
        }
        return count;
    }

    int preimageSizeFZF(int k) {
        long long low = 0;
        long long high = 7000000000LL; // A sufficiently large upper bound for x, considering k up to 10^9.
                                       // f(x) is approximately x/4, so x is approximately 4k.
                                       // For k=10^9, x is around 4*10^9. 7*10^9 is a safe upper limit.

        long long ans_x = -1;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            long long zeros = trailingZeroes(mid);

            if (zeros >= k) {
                ans_x = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        if (ans_x != -1 && trailingZeroes(ans_x) == k) {
            return 5;
        } else {
            return 0;
        }
    }
};