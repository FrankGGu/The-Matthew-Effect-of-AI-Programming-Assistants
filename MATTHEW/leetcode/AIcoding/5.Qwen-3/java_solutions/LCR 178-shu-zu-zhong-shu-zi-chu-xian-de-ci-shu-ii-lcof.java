public class Solution {
    public int[] trainingPlan(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = nums[i];
        }
        return result;
    }
}