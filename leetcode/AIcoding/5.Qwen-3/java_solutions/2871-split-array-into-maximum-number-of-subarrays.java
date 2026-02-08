public class Solution {
    public int maxSubarrays(int[] nums) {
        int result = 0;
        int current = Integer.MAX_VALUE;
        for (int num : nums) {
            current &= num;
            if (current == 0) {
                result++;
                current = Integer.MAX_VALUE;
            }
        }
        return result;
    }
}