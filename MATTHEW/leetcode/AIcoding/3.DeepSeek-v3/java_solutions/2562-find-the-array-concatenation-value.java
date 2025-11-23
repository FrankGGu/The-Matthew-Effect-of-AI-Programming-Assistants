class Solution {
    public long findTheArrayConcVal(int[] nums) {
        long concatValue = 0;
        int left = 0;
        int right = nums.length - 1;

        while (left <= right) {
            if (left == right) {
                concatValue += nums[left];
            } else {
                String concat = String.valueOf(nums[left]) + String.valueOf(nums[right]);
                concatValue += Long.parseLong(concat);
            }
            left++;
            right--;
        }

        return concatValue;
    }
}