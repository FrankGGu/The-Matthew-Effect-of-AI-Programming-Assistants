class Solution {
    public int[] finalArray(int[] nums, int[][] operations) {
        long[] result = new long[nums.length];
        for (int i = 0; i < nums.length; i++) {
            result[i] = nums[i];
        }

        for (int[] op : operations) {
            int index = op[0];
            int value = op[1];
            result[index] *= value;
        }

        for (int i = 0; i < nums.length; i++) {
            result[i] = (int) result[i];
        }

        return result;
    }
}