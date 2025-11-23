class Solution {
    public int minOperations(int[] nums, int k) {
        int n = nums.length;
        int minOps = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            int current = nums[i];
            int ops = 0;

            for (int j = i; j < Math.min(i + k, n); j++) {
                if (nums[j] != current) {
                    ops++;
                }
            }

            minOps = Math.min(minOps, ops);
        }

        return minOps;
    }
}