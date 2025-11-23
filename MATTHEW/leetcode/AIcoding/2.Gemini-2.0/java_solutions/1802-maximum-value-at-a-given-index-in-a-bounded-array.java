class Solution {
    public int maxValue(int n, int index, int maxSum) {
        int left = 1, right = maxSum;
        while (left < right) {
            int mid = (left + right + 1) / 2;
            long sum = mid;
            if (index < mid - 1) {
                sum += (long)mid * (mid - 1) / 2 - (long)(mid - 1 - index) * (mid - index - 2) / 2;
            } else {
                sum += (long)mid * (mid - 1) / 2 + index - mid + 1;
            }
            if (n - index - 1 < mid - 1) {
                sum += (long)mid * (mid - 1) / 2 - (long)(mid - (n - index)) * (mid - (n - index) - 1) / 2;
            } else {
                sum += (long)mid * (mid - 1) / 2 + n - index - mid;
            }
            if (sum > maxSum) {
                right = mid - 1;
            } else {
                left = mid;
            }
        }
        return left;
    }
}