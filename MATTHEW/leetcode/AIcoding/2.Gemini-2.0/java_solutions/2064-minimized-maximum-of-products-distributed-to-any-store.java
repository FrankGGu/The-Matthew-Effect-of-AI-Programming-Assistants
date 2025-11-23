class Solution {
    public int minimizedMaximum(int n, int[] quantities) {
        int left = 1, right = 0;
        for (int q : quantities) {
            right = Math.max(right, q);
        }

        while (left < right) {
            int mid = left + (right - left) / 2;
            long count = 0;
            for (int q : quantities) {
                count += (q + mid - 1) / mid;
            }

            if (count > n) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left;
    }
}