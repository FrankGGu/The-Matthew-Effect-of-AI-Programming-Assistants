class Solution {
    public int numOfWays(int[] nums) {
        int count = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int product = nums[i] * nums[j];
                int squareRoot = (int) Math.sqrt(product);
                if (squareRoot * squareRoot == product) {
                    count++;
                }
            }
        }
        return count;
    }
}