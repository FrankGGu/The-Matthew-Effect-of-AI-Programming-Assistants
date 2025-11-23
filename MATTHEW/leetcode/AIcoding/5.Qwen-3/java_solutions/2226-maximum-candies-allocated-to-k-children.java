public class Solution {
    public long maxCandies(int[] candies, int k) {
        long left = 0;
        long right = Integer.MAX_VALUE;
        long result = 0;

        while (left <= right) {
            long mid = left + (right - left) / 2;
            long count = 0;

            for (int candy : candies) {
                count += candy / mid;
            }

            if (count >= k) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }
}