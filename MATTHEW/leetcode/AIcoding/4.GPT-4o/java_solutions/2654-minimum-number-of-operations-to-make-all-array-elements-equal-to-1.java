class Solution {
    public int minOperations(int[] nums) {
        int count = 0;
        for (int num : nums) {
            if (num != 1) {
                count += (num == 0) ? 1 : Integer.MAX_VALUE;
            }
        }
        return (count == 0) ? 0 : count + (count < Integer.MAX_VALUE ? 1 : 0);
    }
}