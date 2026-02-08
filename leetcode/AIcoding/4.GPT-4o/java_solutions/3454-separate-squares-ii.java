class Solution {
    public int[] separateSquares(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        int index = 0;

        for (int num : nums) {
            if (num >= 0) {
                result[index++] = num;
            }
        }
        for (int num : nums) {
            if (num < 0) {
                result[index++] = num;
            }
        }
        return result;
    }
}