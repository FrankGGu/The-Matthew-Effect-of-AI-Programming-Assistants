class Solution {
    public int countHillsAndValleys(int[] nums) {
        int count = 0;
        for (int i = 1; i < nums.length - 1; i++) {
            if ((nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) || 
                (nums[i] < nums[i - 1] && nums[i] < nums[i + 1])) ) {
                count++;
            }
        }
        return count;
    }
}