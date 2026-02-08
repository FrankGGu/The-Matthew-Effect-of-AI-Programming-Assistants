import java.util.*;

public class Solution {
    public int[] getDecorations(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        Arrays.fill(result, 1);

        for (int i = 1; i < n; i++) {
            if (nums[i] > nums[i - 1]) {
                result[i] = result[i - 1] + 1;
            }
        }

        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] > nums[i + 1]) {
                result[i] = Math.max(result[i], result[i + 1] + 1);
            }
        }

        return result;
    }
}