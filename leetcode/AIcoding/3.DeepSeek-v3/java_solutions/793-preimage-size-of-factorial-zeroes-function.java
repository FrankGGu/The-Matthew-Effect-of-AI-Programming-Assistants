class Solution {
    public int preimageSizeFZF(int k) {
        long left = 0, right = 5L * (k + 1);
        while (left <= right) {
            long mid = left + (right - left) / 2;
            long zeros = trailingZeroes(mid);
            if (zeros == k) {
                return 5;
            } else if (zeros < k) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return 0;
    }

    private long trailingZeroes(long n) {
        long count = 0;
        while (n > 0) {
            n /= 5;
            count += n;
        }
        return count;
    }
}