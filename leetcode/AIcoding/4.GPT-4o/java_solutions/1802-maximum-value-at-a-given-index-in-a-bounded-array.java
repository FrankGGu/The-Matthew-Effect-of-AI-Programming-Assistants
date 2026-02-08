class Solution {
    public int maxValue(int n, int index, int maxSum) {
        int left = Math.max(0, index);
        int right = Math.max(0, n - index - 1);
        int low = 1, high = maxSum;

        while (low < high) {
            int mid = (low + high + 1) / 2;
            if (canAchieve(mid, left, right, n, maxSum)) {
                low = mid;
            } else {
                high = mid - 1;
            }
        }
        return low;
    }

    private boolean canAchieve(int x, int left, int right, int n, int maxSum) {
        long total = x;
        total += (long) Math.min(left, x - 1) * (x - 1 + x - 1 - left + 1) / 2;
        total += (long) Math.min(right, x - 1) * (x - 1 + x - 1 - right + 1) / 2;
        if (left >= x) {
            total += (long) (left - x + 1);
        }
        if (right >= x) {
            total += (long) (right - x + 1);
        }
        return total <= maxSum;
    }
}