import java.util.Arrays;

class Solution {
    public int[] smallestSubarrays(int[] nums) {
        int n = nums.length;
        int[] ans = new int[n];

        int[] maxOrSuffix = new int[n];
        if (n > 0) {
            maxOrSuffix[n - 1] = nums[n - 1];
            for (int i = n - 2; i >= 0; i--) {
                maxOrSuffix[i] = nums[i] | maxOrSuffix[i + 1];
            }
        }

        int[] lastOccurrence = new int[30];
        Arrays.fill(lastOccurrence, -1); 

        for (int i = n - 1; i >= 0; i--) {
            for (int b = 0; b < 30; b++) {
                if (((nums[i] >> b) & 1) == 1) {
                    lastOccurrence[b] = i;
                }
            }

            int targetOr = maxOrSuffix[i];

            if (targetOr == 0) {
                ans[i] = 1;
                continue;
            }

            int maxJ = i; 
            for (int b = 0; b < 30; b++) {
                if (((targetOr >> b) & 1) == 1) {
                    maxJ = Math.max(maxJ, lastOccurrence[b]);
                }
            }

            ans[i] = maxJ - i + 1;
        }

        return ans;
    }
}