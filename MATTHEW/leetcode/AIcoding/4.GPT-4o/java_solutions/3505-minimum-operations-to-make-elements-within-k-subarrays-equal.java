class Solution {
    public int minOperations(int[] nums, int k) {
        int n = nums.length;
        Map<Integer, Integer> count = new HashMap<>();
        for (int i = 0; i < n; i++) {
            count.put(nums[i], count.getOrDefault(nums[i], 0) + 1);
        }

        int minOps = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int operations = 0;
            for (int j = 0; j < n; j++) {
                if (j >= i && j < i + k) {
                    operations += count.getOrDefault(nums[j], 0);
                }
            }
            minOps = Math.min(minOps, operations);
        }

        return minOps;
    }
}