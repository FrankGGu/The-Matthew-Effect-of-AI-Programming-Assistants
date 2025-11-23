import java.util.Arrays;

class Solution {
    public int maximumProduct(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;

        // Option 1: Product of the three largest numbers
        int product1 = nums[n - 1] * nums[n - 2] * nums[n - 3];

        // Option 2: Product of the two smallest (most negative) numbers and the largest number
        // This handles cases like [-100, -2, -3, 1] where (-100)*(-3)*1 is the max
        int product2 = nums[0] * nums[1] * nums[n - 1];

        return Math.max(product1, product2);
    }
}