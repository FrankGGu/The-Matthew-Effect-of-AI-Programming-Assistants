class Solution {
    public int minDays(int[] bloomDay, int m, int k) {
        int n = bloomDay.length;
        if (m * k > n) {
            return -1;
        }

        int left = 1, right = 1;
        for (int day : bloomDay) {
            right = Math.max(right, day);
        }

        int ans = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int bouquets = 0;
            int flowers = 0;
            for (int day : bloomDay) {
                if (day <= mid) {
                    flowers++;
                    if (flowers == k) {
                        bouquets++;
                        flowers = 0;
                    }
                } else {
                    flowers = 0;
                }
            }

            if (bouquets >= m) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
}