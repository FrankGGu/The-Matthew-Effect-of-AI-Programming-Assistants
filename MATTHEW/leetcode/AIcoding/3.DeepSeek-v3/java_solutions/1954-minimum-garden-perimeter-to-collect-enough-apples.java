class Solution {
    public long minimumPerimeter(long neededApples) {
        long left = 1, right = (long)1e5;
        while (left < right) {
            long mid = left + (right - left) / 2;
            if (2 * mid * (mid + 1) * (2 * mid + 1) >= neededApples) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return 8 * left;
    }
}