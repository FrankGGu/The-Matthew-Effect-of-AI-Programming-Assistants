class Solution {
    public long maximumValueSum(int[] nums, int k, int[][] edges) {
        long sum = 0;
        int count = 0;
        long minDiff = Long.MAX_VALUE;

        for (int num : nums) {
            long xor = num ^ k;
            if (xor > num) {
                sum += xor;
                count++;
                minDiff = Math.min(minDiff, xor - num);
            } else {
                sum += num;
                minDiff = Math.min(minDiff, num - xor);
            }
        }

        if (count % 2 == 1) {
            sum -= minDiff;
        }

        return sum;
    }
}