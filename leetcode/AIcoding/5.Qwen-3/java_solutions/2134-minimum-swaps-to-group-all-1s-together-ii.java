public class Solution {

import java.util.*;

public class Solution {
    public int minSwaps(int[] nums) {
        int n = nums.length;
        int totalOnes = 0;
        for (int num : nums) {
            if (num == 1) {
                totalOnes++;
            }
        }
        if (totalOnes == 0 || totalOnes == n) {
            return 0;
        }
        int windowSize = totalOnes;
        int maxOnesInWindow = 0;
        int currentOnes = 0;
        for (int i = 0; i < windowSize; i++) {
            if (nums[i] == 1) {
                currentOnes++;
            }
        }
        maxOnesInWindow = currentOnes;
        for (int i = windowSize; i < n; i++) {
            if (nums[i - windowSize] == 1) {
                currentOnes--;
            }
            if (nums[i] == 1) {
                currentOnes++;
            }
            maxOnesInWindow = Math.max(maxOnesInWindow, currentOnes);
        }
        return windowSize - maxOnesInWindow;
    }
}
}