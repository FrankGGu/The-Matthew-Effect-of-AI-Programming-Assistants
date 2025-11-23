class Solution {
    public int maxValue(int n, int index, int maxSum) {
        int left = 1, right = maxSum;
        while (left < right) {
            int mid = (left + right + 1) / 2;
            if (isPossible(n, index, mid, maxSum)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }

    private boolean isPossible(int n, int index, int mid, int maxSum) {
        long sum = 0;
        // left side
        if (mid > index) {
            sum += (long)(mid + mid - index) * (index + 1) / 2;
        } else {
            sum += (long)(mid + 1) * mid / 2 + (index - mid + 1);
        }
        // right side
        if (mid >= n - index) {
            sum += (long)(mid + mid - (n - 1 - index)) * (n - index) / 2;
        } else {
            sum += (long)(mid + 1) * mid / 2 + (n - index - mid);
        }
        sum -= mid;
        return sum <= maxSum;
    }
}