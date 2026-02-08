public class Solution {
    public int earliestSecondToMarkIndices(int[] nums) {
        int n = nums.length;
        int[] count = new int[n];
        int max = 0;
        for (int i = 0; i < n; i++) {
            count[i] = nums[i];
            max = Math.max(max, nums[i]);
        }
        int result = 0;
        while (true) {
            boolean allZero = true;
            for (int i = 0; i < n; i++) {
                if (count[i] > 0) {
                    allZero = false;
                    count[i]--;
                }
            }
            if (allZero) break;
            result++;
        }
        return result;
    }
}