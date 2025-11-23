class Solution {
    public int findKthNumber(int m, int n, int k) {
        int low = 1;
        int high = m * n;
        int ans = m * n;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            int count = 0;
            for (int i = 1; i <= m; i++) {
                count += Math.min(n, mid / i);
            }

            if (count >= k) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }
}