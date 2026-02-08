import java.util.HashMap;

class Solution {
    public int findShortestSubarray(int[] nums) {
        HashMap<Integer, Integer> firstIndex = new HashMap<>();
        HashMap<Integer, Integer> count = new HashMap<>();
        int degree = 0;

        for (int i = 0; i < nums.length; i++) {
            count.put(nums[i], count.getOrDefault(nums[i], 0) + 1);
            if (!firstIndex.containsKey(nums[i])) {
                firstIndex.put(nums[i], i);
            }
            degree = Math.max(degree, count.get(nums[i]));
        }

        int minLength = Integer.MAX_VALUE;
        for (int num : count.keySet()) {
            if (count.get(num) == degree) {
                minLength = Math.min(minLength, nums.length - firstIndex.get(num) - (count.get(num) - 1));
            }
        }

        return minLength;
    }
}