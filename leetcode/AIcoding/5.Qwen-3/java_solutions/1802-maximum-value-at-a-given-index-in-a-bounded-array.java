public class Solution {
    public int maxValue(int n, int index, int maxSum) {
        int left = 1, right = maxSum;
        while (left < right) {
            int mid = (left + right + 1) / 2;
            if (check(n, index, maxSum, mid)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }

    private boolean check(int n, int index, int maxSum, int val) {
        int left = index;
        int right = n - index - 1;
        int sum = 0;
        int l = Math.max(0, val - left);
        sum += (val + l) * left / 2;
        int r = Math.max(0, val - right);
        sum += (val + r) * right / 2;
        sum -= val;
        return sum <= maxSum;
    }
}