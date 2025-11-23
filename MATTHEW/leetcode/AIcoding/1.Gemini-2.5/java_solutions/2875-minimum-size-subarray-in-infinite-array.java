class Solution {
    public int minSizeSubarray(int[] nums, int target) {
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        int n = nums.length;

        long fullCycles = target / totalSum;
        long remainingTarget = target % totalSum;

        int minLenForRemainder = Integer.MAX_VALUE;

        if (remainingTarget == 0) {
            minLenForRemainder = 0;
        } else {
            long currentSum = 0;
            int left = 0;
            for (int right = 0; right < 2 * n; right++) {
                currentSum += nums[right % n];
                while (currentSum >= remainingTarget) {
                    if (currentSum == remainingTarget) {
                        minLenForRemainder = Math.min(minLenForRemainder, right - left + 1);
                    }
                    currentSum -= nums[left % n];
                    left++;
                }
            }
        }

        if (minLenForRemainder == Integer.MAX_VALUE) {
            return -1;
        } else {
            return (int)(fullCycles * n + minLenForRemainder);
        }
    }
}