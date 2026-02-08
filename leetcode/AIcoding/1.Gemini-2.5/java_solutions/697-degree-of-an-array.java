import java.util.HashMap;
import java.util.Map;

class Solution {
    public int findShortestSubArray(int[] nums) {
        Map<Integer, Integer> countMap = new HashMap<>();
        Map<Integer, Integer> firstMap = new HashMap<>();
        Map<Integer, Integer> lastMap = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
            if (!firstMap.containsKey(num)) {
                firstMap.put(num, i);
            }
            lastMap.put(num, i);
        }

        int degree = 0;
        for (int count : countMap.values()) {
            degree = Math.max(degree, count);
        }

        int minLength = Integer.MAX_VALUE;
        for (int num : countMap.keySet()) {
            if (countMap.get(num) == degree) {
                int length = lastMap.get(num) - firstMap.get(num) + 1;
                minLength = Math.min(minLength, length);
            }
        }

        return minLength;
    }
}