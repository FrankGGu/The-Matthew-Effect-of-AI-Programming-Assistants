public class Solution {
    public int minOperations(int[] nums) {
        int operations = 0;
        int flip = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == flip % 2) {
                operations++;
                flip++;
            }
        }
        return operations;
    }
}