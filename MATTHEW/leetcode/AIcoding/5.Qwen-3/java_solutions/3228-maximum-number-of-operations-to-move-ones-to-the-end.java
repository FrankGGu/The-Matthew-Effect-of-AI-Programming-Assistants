public class Solution {
    public int maximumOperations(int[] nums) {
        int count = 0;
        int ones = 0;
        for (int num : nums) {
            if (num == 1) {
                ones++;
            } else {
                count += ones;
            }
        }
        return count;
    }
}