import java.util.HashMap;
import java.util.Map;

class Solution {
    public int mostFrequent(int[] nums, int key) {
        Map<Integer, Integer> countMap = new HashMap<>();
        int maxCount = 0;
        int mostFrequent = -1;

        for (int i = 0; i < nums.length - 1; i++) {
            if (nums[i] == key) {
                int target = nums[i + 1];
                countMap.put(target, countMap.getOrDefault(target, 0) + 1);
                if (countMap.get(target) > maxCount) {
                    maxCount = countMap.get(target);
                    mostFrequent = target;
                }
            }
        }

        return mostFrequent;
    }
}