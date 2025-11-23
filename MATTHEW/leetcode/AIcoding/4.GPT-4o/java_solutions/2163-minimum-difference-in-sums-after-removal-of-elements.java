class Solution {
    public int minimumDifference(int[] nums) {
        int n = nums.length;
        int totalSum = 0;
        for (int num : nums) totalSum += num;

        int half = n / 2;
        int[] leftSums = new int[1 << half];

        for (int mask = 0; mask < (1 << half); mask++) {
            int sum = 0;
            for (int i = 0; i < half; i++) {
                if ((mask & (1 << i)) != 0) {
                    sum += nums[i];
                }
            }
            leftSums[mask] = sum;
        }

        Arrays.sort(leftSums);
        int minDiff = Integer.MAX_VALUE;

        for (int mask = 0; mask < (1 << (n - half)); mask++) {
            int sum = 0;
            for (int i = 0; i < n - half; i++) {
                if ((mask & (1 << i)) != 0) {
                    sum += nums[half + i];
                }
            }
            int target = totalSum / 2 - sum;
            int index = Arrays.binarySearch(leftSums, target);
            if (index < 0) index = -index - 2;

            if (index >= 0) {
                minDiff = Math.min(minDiff, Math.abs(totalSum - 2 * (leftSums[index] + sum)));
            }
            if (index + 1 < leftSums.length) {
                minDiff = Math.min(minDiff, Math.abs(totalSum - 2 * (leftSums[index + 1] + sum)));
            }
        }

        return minDiff;
    }
}