class Solution {
    public int countKReducibleNumbers(int k, long n) {
        int count = 0;
        for (long i = 1; i < n; i++) {
            if (isKReducible(i, k)) {
                count++;
            }
        }
        return count;
    }

    private boolean isKReducible(long num, int k) {
        if (num < k) {
            return false;
        }

        while (num >= k) {
            if (num % k != 0) {
                return false;
            }
            num /= k;
        }

        return true;
    }
}