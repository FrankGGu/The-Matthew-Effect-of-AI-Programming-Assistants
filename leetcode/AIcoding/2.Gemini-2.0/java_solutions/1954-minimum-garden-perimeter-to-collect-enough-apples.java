class Solution {
    public long minimumPerimeter(long neededApples) {
        long low = 1, high = 100000;
        long ans = 0;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            long apples = 2 * mid * (mid + 1) * 6;

            if (apples >= neededApples) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans * 8;
    }
}