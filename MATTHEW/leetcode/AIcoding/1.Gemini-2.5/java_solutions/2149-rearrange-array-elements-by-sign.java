class Solution {
    public int[] rearrangeArray(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        int positiveIndex = 0;
        int negativeIndex = 1;

        for (int i = 0; i < n; i++) {
            if (nums[i] > 0) {
                result[positiveIndex] = nums[i];
                positiveIndex += 2;
            } else {
                result[negativeIndex] = nums[i];
                negativeIndex += 2;
            }
        }
        return result;
    }
}