class Solution {
    public long[] countOfPairs(int n, int x, int y) {
        long[] ans = new long[n]; // ans[k] will store count for distance k+1

        // Ensure x is always less than or equal to y for consistent logic, though Math.abs handles it.
        // This swap is not strictly necessary but can make reasoning slightly clearer.
        if (x > y) {
            int temp = x;
            x = y;
            y = temp;
        }

        for (int i = 1; i <= n; i++) {
            for (int j = i + 1; j <= n; j++) {
                // Calculate distance along the main street
                int dist1 = j - i;

                // Calculate distance using the special road x-y
                // Path: i -> ... -> x -> y -> ... -> j
                int dist2 = Math.abs(i - x) + 1 + Math.abs(y - j);

                // Path: i -> ... -> y -> x -> ... -> j (This is covered by dist2 if x and y are swapped)
                // However, the problem statement means x and y are specific points,
                // so we consider both paths through the special road.
                // The current x, y values are fixed based on input.
                // So, it's |i - original_x| + 1 + |original_y - j|
                // and |i - original_y| + 1 + |original_x - j|
                // Since we swapped x and y at the beginning if x > y,
                // the variables x and y now represent the smaller and larger of the two given points.
                // So, the two paths through the special road are effectively:
                // 1. i -> ... -> x (smaller index) -> y (larger index) -> ... -> j
                // 2. i -> ... -> y (larger index) -> x (smaller index) -> ... -> j
                // These are represented by Math.abs(i - x) + 1 + Math.abs(y - j) and Math.abs(i - y) + 1 + Math.abs(x - j)
                // using the original x and y values.
                // Since we swapped x and y if x > y, let's use the original x_orig, y_orig for clarity
                // Or simply use the current x, y variables as they are after potential swap.
                // The two paths are:
                // Path 1: i -> x -> y -> j
                // Path 2: i -> y -> x -> j
                // The minimum of these two is taken.
                int current_dist = Math.min(dist1, Math.abs(i - x) + 1 + Math.abs(j - y));
                current_dist = Math.min(current_dist, Math.abs(i - y) + 1 + Math.abs(j - x));

                ans[current_dist - 1]++;
            }
        }

        return ans;
    }
}