class Solution {
    public int minOperations(int[] nums) {
        int min = Integer.MAX_VALUE;
        for (int num : nums) {
            min = Math.min(min, num);
        }
        int operations = 0;
        for (int num : nums) {
            operations += num - min;
        }
        return operations;
    }
}