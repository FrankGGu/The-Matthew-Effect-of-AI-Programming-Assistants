class Solution {
    public int waysToPartition(int[] nums, int k) {
        int n = nums.length;
        long[] prefix = new long[n];
        prefix[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefix[i] = prefix[i - 1] + nums[i];
        }

        Map<Long, Integer> right = new HashMap<>();
        for (int i = 1; i < n; i++) {
            long diff = prefix[i - 1] - (prefix[n - 1] - prefix[i - 1]);
            right.put(diff, right.getOrDefault(diff, 0) + 1);
        }

        int res = right.getOrDefault(0L, 0);

        Map<Long, Integer> left = new HashMap<>();
        for (int i = 0; i < n; i++) {
            long oldDiff = prefix[i] - (prefix[n - 1] - prefix[i]);
            if (i < n - 1) {
                long newDiff = oldDiff + (k - nums[i]);
                int count = right.getOrDefault(-newDiff, 0) + left.getOrDefault(newDiff, 0);
                res = Math.max(res, count);
            }

            if (i < n - 1) {
                long diff = prefix[i] - (prefix[n - 1] - prefix[i]);
                right.put(diff, right.getOrDefault(diff, 0) - 1);
            }

            long diff = prefix[i] - (prefix[n - 1] - prefix[i]);
            left.put(diff, left.getOrDefault(diff, 0) + 1);
        }

        return res;
    }
}