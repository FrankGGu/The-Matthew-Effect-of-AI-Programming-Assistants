class Solution {
    public int[] finalArrayState(int[] nums, int k) {
        if (nums == null || nums.length == 0) {
            return new int[0];
        }

        long multiplier = 1;
        for (int i = 0; i < k; i++) {
            multiplier *= k;
        }

        for (int i = 0; i < nums.length; i++) {
            nums[i] = (int) (nums[i] * multiplier);
        }

        return nums;
    }
}