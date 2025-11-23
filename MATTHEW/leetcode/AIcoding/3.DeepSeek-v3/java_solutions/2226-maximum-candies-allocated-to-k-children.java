class Solution {
    public int maximumCandies(int[] candies, long k) {
        long sum = 0;
        for (int candy : candies) {
            sum += candy;
        }
        if (sum < k) {
            return 0;
        }

        int left = 1;
        int right = (int) (sum / k);
        int result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canAllocate(candies, k, mid)) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }

    private boolean canAllocate(int[] candies, long k, int candiesPerChild) {
        long children = 0;
        for (int candy : candies) {
            children += candy / candiesPerChild;
            if (children >= k) {
                return true;
            }
        }
        return false;
    }
}