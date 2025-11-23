class Solution {
    public int maximumGap(int[] nums) {
        if (nums == null || nums.length < 2) {
            return 0;
        }

        int min = nums[0];
        int max = nums[0];
        for (int num : nums) {
            min = Math.min(min, num);
            max = Math.max(max, num);
        }

        int gap = (int) Math.ceil((double) (max - min) / (nums.length - 1));
        if (gap == 0) {
            return 0;
        }

        int bucketNum = (max - min) / gap + 1;
        int[] bucketMin = new int[bucketNum];
        int[] bucketMax = new int[bucketNum];
        Arrays.fill(bucketMin, Integer.MAX_VALUE);
        Arrays.fill(bucketMax, Integer.MIN_VALUE);

        for (int num : nums) {
            int idx = (num - min) / gap;
            bucketMin[idx] = Math.min(bucketMin[idx], num);
            bucketMax[idx] = Math.max(bucketMax[idx], num);
        }

        int maxGap = 0;
        int prev = min;
        for (int i = 0; i < bucketNum; i++) {
            if (bucketMin[i] == Integer.MAX_VALUE && bucketMax[i] == Integer.MIN_VALUE) {
                continue;
            }
            maxGap = Math.max(maxGap, bucketMin[i] - prev);
            prev = bucketMax[i];
        }

        return maxGap;
    }
}