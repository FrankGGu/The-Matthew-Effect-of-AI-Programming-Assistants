class Solution {
    public int findShortestSubArray(int[] nums) {
        Map<Integer, Integer> left = new HashMap<>();
        Map<Integer, Integer> right = new HashMap<>();
        Map<Integer, Integer> count = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];
            if (!left.containsKey(num)) {
                left.put(num, i);
            }
            right.put(num, i);
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        int degree = Collections.max(count.values());
        int minLength = Integer.MAX_VALUE;

        for (int num : count.keySet()) {
            if (count.get(num) == degree) {
                minLength = Math.min(minLength, right.get(num) - left.get(num) + 1);
            }
        }

        return minLength;
    }
}