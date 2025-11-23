import java.util.Arrays;

class Solution {
    public int maxProfit(int[] inventory, int orders) {
        long left = 1, right = (long) 1e9, MOD = 1_000_000_007;
        while (left < right) {
            long mid = right - (right - left) / 2;
            if (canFulfill(inventory, mid, orders)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return (int) calculateProfit(inventory, left, orders, MOD);
    }

    private boolean canFulfill(int[] inventory, long h, int orders) {
        long total = 0;
        for (int balls : inventory) {
            if (balls >= h) {
                total += balls - h + 1;
            }
            if (total >= orders) {
                return true;
            }
        }
        return total >= orders;
    }

    private long calculateProfit(int[] inventory, long h, int orders, long MOD) {
        long total = 0;
        for (int balls : inventory) {
            if (balls >= h) {
                total += (long) (balls + h) * (balls - h + 1) / 2;
                total %= MOD;
                orders -= balls - h + 1;
            } else {
                total += (long) (balls + 1) * balls / 2;
                total %= MOD;
            }
            if (orders <= 0) break;
        }
        return total;
    }
}