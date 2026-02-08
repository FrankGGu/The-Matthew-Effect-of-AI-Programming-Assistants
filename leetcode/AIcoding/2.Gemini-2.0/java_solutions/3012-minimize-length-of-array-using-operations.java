class Solution {
    public int minimumArrayLength(int[] nums) {
        int minVal = Integer.MAX_VALUE;
        int count = 0;
        for (int num : nums) {
            minVal = Math.min(minVal, num);
        }
        for (int num : nums) {
            if (num == minVal) {
                count++;
            }
        }
        if (count > (nums.length + 1) / 2) {
            return count - (nums.length - count);
        }

        for (int num : nums) {
            if (num % minVal != 0) {
                return nums.length;
            }
        }
        return (nums.length + 1) / 2;
    }
}