class Solution {
    public int minEatingSpeed(int[] piles, int h) {
        int maxPile = 0;
        for (int pile : piles) {
            if (pile > maxPile) {
                maxPile = pile;
            }
        }

        int left = 1;
        int right = maxPile;
        int ans = maxPile;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canFinish(piles, h, mid)) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }

    private boolean canFinish(int[] piles, int h, int k) {
        long hoursNeeded = 0;
        for (int pile : piles) {
            hoursNeeded += (pile + k - 1) / k;
        }
        return hoursNeeded <= h;
    }
}