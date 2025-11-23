class Solution {
    public int minOperations(int[] nums) {
        int count = 0;
        for (int num : nums) {
            int remainder = num % 3;
            if (remainder == 1) {
                count += 2;
            } else if (remainder == 2) {
                count += 1;
            }
        }
        return count;
    }
}