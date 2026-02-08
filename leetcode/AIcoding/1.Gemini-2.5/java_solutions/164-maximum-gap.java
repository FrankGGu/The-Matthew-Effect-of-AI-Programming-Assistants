import java.util.Arrays;

class Solution {
    public int maximumGap(int[] nums) {
        int n = nums.length;
        if (n < 2) {
            return 0;
        }

        int minVal = nums[0];
        int maxVal = nums[0];
        for (int i = 1; i < n; i++) {
            minVal = Math.min(minVal, nums[i]);
            maxVal = Math.max(maxVal, nums[i]);
        }

        if (minVal == maxVal) {
            return 0;
        }

        int bucketSize = Math.max(1, (maxVal - minVal) / (n - 1));
        int numBuckets = (maxVal - minVal) / bucketSize + 1;

        int[] minBucket = new int[numBuckets];
        int[] maxBucket = new int[numBuckets];
        boolean[] hasElement = new boolean[numBuckets];

        Arrays.fill(minBucket, Integer.MAX_VALUE);
        Arrays.fill(maxBucket, Integer.MIN_VALUE);

        for (int num : nums) {
            int bucketIndex = (num - minVal) / bucketSize;
            minBucket[bucketIndex] = Math.min(minBucket[bucketIndex], num);
            maxBucket[bucketIndex] = Math.max(maxBucket[bucketIndex], num);
            hasElement[bucketIndex] = true;
        }

        int maxGap = 0;
        int prevMax = minVal;

        for (int i = 0; i < numBuckets; i++) {
            if (hasElement[i]) {
                maxGap = Math.max(maxGap, minBucket[i] - prevMax);
                prevMax = maxBucket[i];
            }
        }

        return maxGap;
    }
}