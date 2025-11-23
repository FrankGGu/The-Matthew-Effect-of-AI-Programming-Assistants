class Solution {
    public int minOperations(int[] nums, int k) {
        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        int remainder = totalSum % k;
        if (remainder == 0) {
            return 0;
        }

        int minOperations = Integer.MAX_VALUE;
        int prefixSum = 0;
        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, -1);

        for (int i = 0; i < nums.length; i++) {
            prefixSum += nums[i];
            int currentRem = prefixSum % k;
            int targetRem = (currentRem - remainder + k) % k;

            if (map.containsKey(targetRem)) {
                int len = i - map.get(targetRem);
                if (len < minOperations) {
                    minOperations = len;
                }
            }
            map.put(currentRem, i);
        }

        return minOperations == Integer.MAX_VALUE ? -1 : minOperations;
    }
}