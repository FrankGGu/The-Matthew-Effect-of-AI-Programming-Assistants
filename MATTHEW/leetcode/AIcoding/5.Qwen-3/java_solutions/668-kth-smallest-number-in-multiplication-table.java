public class Solution {
    public int findKthNumber(int m, int n, int k) {
        int left = 1;
        int right = m * n;

        while (left < right) {
            int mid = left + (right - left) / 2;
            int count = countLessEqual(mid, m, n);

            if (count < k) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left;
    }

    private int countLessEqual(int x, int m, int n) {
        int count = 0;
        for (int i = 1; i <= m && i <= x; i++) {
            int temp = x / i;
            if (temp > n) {
                count += n;
            } else {
                count += temp;
            }
        }
        return count;
    }
}