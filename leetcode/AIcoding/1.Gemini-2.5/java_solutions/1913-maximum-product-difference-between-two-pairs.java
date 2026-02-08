import java.util.Arrays;

class Solution {
    public int maxProductDifference(int[] nums) {
        int max1 = 0; // Largest
        int max2 = 0; // Second largest
        int min1 = 10001; // Smallest (nums[i] <= 10^4, so 10001 is a safe initial value)
        int min2 = 10001; // Second smallest

        for (int num : nums) {
            // Update max1 and max2
            if (num >= max1) {
                max2 = max1;
                max1 = num;
            } else if (num > max2) {
                max2 = num;
            }

            // Update min1 and min2
            if (num <= min1) {
                min2 = min1;
                min1 = num;
            } else if (num < min2) {
                min2 = num;
            }
        }

        return (max1 * max2) - (min1 * min2);
    }
}