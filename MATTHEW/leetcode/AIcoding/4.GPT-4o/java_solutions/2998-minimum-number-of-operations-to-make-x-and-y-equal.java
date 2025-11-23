class Solution {
    public int minOperations(int[] nums, int x, int y) {
        int target = x + y;
        int total = 0;
        for (int num : nums) {
            total += num;
        }
        int required = total - target;
        if (required < 0) return -1;

        int maxLength = 0;
        int currentSum = 0;
        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, -1);

        for (int i = 0; i < nums.length; i++) {
            currentSum += nums[i];
            if (map.containsKey(currentSum - required)) {
                maxLength = Math.max(maxLength, i - map.get(currentSum - required));
            }
            map.put(currentSum, i);
        }

        return maxLength == 0 && required != 0 ? -1 : nums.length - maxLength;
    }
}