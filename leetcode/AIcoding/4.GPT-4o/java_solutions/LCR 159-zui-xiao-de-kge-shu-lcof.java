class Solution {
    public int maxProfit(int[] inventory, int orders) {
        long left = 1, right = (long) 1e9, res = 0, mod = (long) 1e9 + 7;

        while (left <= right) {
            long mid = left + (right - left) / 2;
            long totalOrders = 0;

            for (int count : inventory) {
                if (count > mid) {
                    totalOrders += count - mid;
                }
                if (totalOrders > orders) break;
            }

            if (totalOrders >= orders) {
                res = (res + (mid * orders) % mod) % mod;
                right = mid - 1;
            } else {
                res = (res + (mid * totalOrders) % mod) % mod;
                orders -= totalOrders;
                left = mid + 1;
            }
        }

        return (int) res;
    }
}