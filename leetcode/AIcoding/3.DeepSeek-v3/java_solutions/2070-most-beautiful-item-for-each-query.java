class Solution {
    public int[] maximumBeauty(int[][] items, int[] queries) {
        Arrays.sort(items, (a, b) -> a[0] - b[0]);
        int n = items.length;
        int[] maxBeauty = new int[n];
        maxBeauty[0] = items[0][1];
        for (int i = 1; i < n; i++) {
            maxBeauty[i] = Math.max(maxBeauty[i - 1], items[i][1]);
        }

        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int left = 0, right = n - 1;
            int best = 0;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (items[mid][0] <= queries[i]) {
                    best = maxBeauty[mid];
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            res[i] = best;
        }
        return res;
    }
}