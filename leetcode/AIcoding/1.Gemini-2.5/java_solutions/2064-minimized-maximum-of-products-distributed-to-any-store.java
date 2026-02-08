import java.util.Arrays;

class Solution {
    public int minimizedMaximum(int n, int[] quantities) {
        int low = 1;
        int high = 0;
        for (int q : quantities) {
            high = Math.max(high, q);
        }

        int ans = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, n, quantities)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }

    private boolean check(int maxProductsPerStore, int n, int[] quantities) {
        long storesRequired = 0;
        for (int q : quantities) {
            // Calculate ceil(q / maxProductsPerStore) using integer division
            storesRequired += (q + maxProductsPerStore - 1) / maxProductsPerStore;
            // Optimization: if we already exceed n stores, this mid value is too small
            if (storesRequired > n) {
                return false;
            }
        }
        return true; // All quantities can be distributed using 'maxProductsPerStore' as max, within 'n' stores
    }
}