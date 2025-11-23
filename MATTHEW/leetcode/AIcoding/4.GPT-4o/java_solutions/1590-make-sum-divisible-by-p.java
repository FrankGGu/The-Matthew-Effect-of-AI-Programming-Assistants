class Solution {
    public int minSubarray(int[] nums, int p) {
        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }
        int targetRemainder = totalSum % p;
        if (targetRemainder == 0) return 0;

        int minLength = Integer.MAX_VALUE;
        Map<Integer, Integer> remainderIndex = new HashMap<>();
        remainderIndex.put(0, -1);
        int currentSum = 0;

        for (int i = 0; i < nums.length; i++) {
            currentSum += nums[i];
            int currentRemainder = currentSum % p;
            int neededRemainder = (currentRemainder - targetRemainder + p) % p;

            if (remainderIndex.containsKey(neededRemainder)) {
                minLength = Math.min(minLength, i - remainderIndex.get(neededRemainder));
            }

            remainderIndex.put(currentRemainder, i);
        }

        return minLength == Integer.MAX_VALUE ? -1 : minLength;
    }
}