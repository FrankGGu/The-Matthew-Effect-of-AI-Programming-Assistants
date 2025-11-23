import java.util.Arrays;

class Solution {
    public int maximumStrength(int[] nums) {
        Arrays.sort(nums);
        int maxProduct = 1;
        int negativeCount = 0;
        boolean hasZero = false;

        for (int num : nums) {
            if (num == 0) {
                hasZero = true;
            } else if (num < 0) {
                negativeCount++;
                if (negativeCount % 2 == 0) {
                    maxProduct *= num;
                } else {
                    maxProduct *= (negativeCount == 1) ? 1 : num;
                }
            } else {
                maxProduct *= num;
            }
        }

        if (maxProduct < 0 && negativeCount % 2 == 1) {
            maxProduct = 1;
        }
        return maxProduct == 1 && !hasZero ? 0 : maxProduct;
    }
}