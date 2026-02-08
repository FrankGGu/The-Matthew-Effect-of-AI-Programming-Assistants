public class Solution {
    public int minDays(int[] bloomDays, int m, int n) {
        if (m * n > bloomDays.length) return -1;

        int left = 1, right = 0;
        for (int day : bloomDays) {
            right = Math.max(right, day);
        }

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canMakeBouquets(bloomDays, m, n, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }

    private boolean canMakeBouquets(int[] bloomDays, int m, int n, int days) {
        int bouquets = 0;
        int consecutive = 0;

        for (int day : bloomDays) {
            if (day <= days) {
                consecutive++;
                if (consecutive == n) {
                    bouquets++;
                    consecutive = 0;
                }
            } else {
                consecutive = 0;
            }

            if (bouquets >= m) return true;
        }

        return bouquets >= m;
    }
}