class Solution {
    public int minEatingSpeed(int[] piles, int h) {
        int maxPile = 0;
        for (int pile : piles) {
            maxPile = Math.max(maxPile, pile);
        }

        int left = 1;
        int right = maxPile;
        int ans = maxPile;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canFinish(piles, mid, h)) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }

    private boolean canFinish(int[] piles, int k, int h) {
        long hoursNeeded = 0;
        for (int pile : piles) {
            hoursNeeded += (pile + k - 1) / k;
            if (hoursNeeded > h) {
                return false;
            }
        }
        return true;
    }
}