class Solution {
    public int waysToMakeFair(int[] nums) {
        int n = nums.length;
        int[] leftOdd = new int[n + 1];
        int[] leftEven = new int[n + 1];
        for (int i = 0; i < n; i++) {
            leftOdd[i + 1] = leftOdd[i];
            leftEven[i + 1] = leftEven[i];
            if (i % 2 == 0) {
                leftEven[i + 1] += nums[i];
            } else {
                leftOdd[i + 1] += nums[i];
            }
        }
        int res = 0;
        for (int i = 0; i < n; i++) {
            int rightOdd = leftOdd[n] - leftOdd[i + 1];
            int rightEven = leftEven[n] - leftEven[i + 1];
            int totalOdd = leftOdd[i] + rightEven;
            int totalEven = leftEven[i] + rightOdd;
            if (totalOdd == totalEven) {
                res++;
            }
        }
        return res;
    }
}