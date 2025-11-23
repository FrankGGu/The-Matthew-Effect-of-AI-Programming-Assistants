class Solution {
    public long sumOfInitialPositions(int[] nums, String directions, int k) {
        long totalSum = 0;
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            if (directions.charAt(i) == 'R') {
                totalSum += (long) nums[i] + k;
            } else { // directions.charAt(i) == 'L'
                totalSum += (long) nums[i] - k;
            }
        }
        return totalSum;
    }
}