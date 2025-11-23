class Solution {
public:
    int preimageSizeFZF(int K) {
        auto countZeroes = [](long long n) {
            int count = 0;
            while (n > 0) {
                n /= 5;
                count += n;
            }
            return count;
        };

        long long left = 0, right = 5 * (K + 1);
        while (left < right) {
            long long mid = left + (right - left) / 2;
            if (countZeroes(mid) < K) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        if (countZeroes(left) != K) return 0;
        return 5;
    }
};