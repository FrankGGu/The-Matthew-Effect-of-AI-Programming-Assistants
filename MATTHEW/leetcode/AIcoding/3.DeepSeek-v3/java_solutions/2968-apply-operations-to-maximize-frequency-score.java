class Solution {
    public int maxFrequencyScore(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int left = 0;
        int maxFreq = 0;

        for (int right = 0; right < n; right++) {
            while (!isValid(left, right, nums, prefix, k)) {
                left++;
            }
            maxFreq = Math.max(maxFreq, right - left + 1);
        }
        return maxFreq;
    }

    private boolean isValid(int left, int right, int[] nums, long[] prefix, int k) {
        int mid = (left + right) / 2;
        long sumLeft = nums[mid] * (mid - left) - (prefix[mid] - prefix[left]);
        long sumRight = (prefix[right + 1] - prefix[mid + 1]) - nums[mid] * (right - mid);
        return sumLeft + sumRight <= k;
    }
}