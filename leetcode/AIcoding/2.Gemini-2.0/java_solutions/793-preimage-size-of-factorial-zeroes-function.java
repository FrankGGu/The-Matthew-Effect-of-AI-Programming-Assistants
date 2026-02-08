class Solution {
    public int preimageSize(int k) {
        return (int)(helper(k + 1) - helper(k));
    }

    private long helper(int k) {
        long low = 0, high = 5L * k;
        while (low <= high) {
            long mid = low + (high - low) / 2;
            long count = countTrailingZeroes(mid);
            if (count < k) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return low;
    }

    private long countTrailingZeroes(long n) {
        long count = 0;
        for (long i = 5; n / i >= 1; i *= 5) {
            count += n / i;
        }
        return count;
    }
}