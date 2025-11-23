class Solution {
    public int maximumCandies(int[] candies, long k) {
        int maxVal = 0;
        for (int candy : candies) {
            maxVal = Math.max(maxVal, candy);
        }

        int low = 0;
        int high = maxVal;
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;

            if (mid == 0) { 
                // If mid is 0, it means we are checking if 0 candies can be allocated.
                // This is always possible, but we are looking for the maximum positive value.
                // If the largest possible value is 0, 'ans' will remain 0.
                // We should try to find a positive value, so move 'low' to 1.
                low = 1;
                continue;
            }

            if (canAllocate(candies, k, mid)) {
                ans = mid;
                low = mid + 1; // Try to allocate more candies per child
            } else {
                high = mid - 1; // Need to allocate fewer candies per child
            }
        }

        return ans;
    }

    private boolean canAllocate(int[] candies, long k, int x) {
        // This function assumes x > 0.
        // If x is 0, division by zero would occur.
        // The main binary search handles x=0 explicitly.

        long childrenCount = 0;
        for (int pile : candies) {
            childrenCount += pile / x;
        }
        return childrenCount >= k;
    }
}