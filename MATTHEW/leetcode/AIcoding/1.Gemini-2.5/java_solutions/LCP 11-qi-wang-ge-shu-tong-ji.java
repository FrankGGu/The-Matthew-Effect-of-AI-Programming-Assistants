class Solution {
    public int expectedNumbers(int[] nums, int lower, int upper) {
        int count = 0;
        for (int num : nums) {
            if (num >= lower && num <= upper) {
                count++;
            }
        }
        return count;
    }
}