import java.util.Arrays;

class Solution {
    public int[] maximumBeauty(int[][] items, int[] queries) {
        Arrays.sort(items, (a, b) -> a[0] - b[0]);
        int n = items.length;
        int m = queries.length;
        int[] ans = new int[m];
        int maxBeauty = 0;
        for (int i = 0; i < n; i++) {
            maxBeauty = Math.max(maxBeauty, items[i][1]);
            items[i][1] = maxBeauty;
        }
        for (int i = 0; i < m; i++) {
            int query = queries[i];
            int left = 0, right = n - 1;
            int best = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (items[mid][0] <= query) {
                    best = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            if (best == -1) {
                ans[i] = 0;
            } else {
                ans[i] = items[best][1];
            }
        }
        return ans;
    }
}