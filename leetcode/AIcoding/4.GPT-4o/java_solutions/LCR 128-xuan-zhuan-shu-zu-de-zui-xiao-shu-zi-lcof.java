class Solution {
    public int maxProfit(int[] inventory, int orders) {
        long left = 1, right = 0;
        for (int num : inventory) {
            right = Math.max(right, num);
        }
        long total = 0;
        while (left < right) {
            long mid = left + (right - left) / 2;
            total = 0;
            for (int num : inventory) {
                if (num > mid) {
                    total += num - mid;
                }
            }
            if (total >= orders) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        long res = 0;
        for (int num : inventory) {
            if (num >= left) {
                res += (num - left + 1) * (num - left) / 2;
                orders -= (num - left);
            } else {
                res += (num * (num + 1)) / 2;
            }
            if (orders <= 0) break;
        }
        res = (res % 1000000007 + (long) orders * left) % 1000000007;
        return (int) res;
    }
}