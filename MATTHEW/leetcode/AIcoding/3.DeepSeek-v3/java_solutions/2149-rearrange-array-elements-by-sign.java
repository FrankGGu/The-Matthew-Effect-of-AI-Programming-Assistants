class Solution {
    public int[] rearrangeArray(int[] nums) {
        int[] result = new int[nums.length];
        int positiveIndex = 0;
        int negativeIndex = 1;

        for (int num : nums) {
            if (num > 0) {
                result[positiveIndex] = num;
                positiveIndex += 2;
            } else {
                result[negativeIndex] = num;
                negativeIndex += 2;
            }
        }

        return result;
    }
}