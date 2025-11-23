import java.util.HashMap;
import java.util.Map;

class Solution {
    public int longestEqualSubarray(int[] nums, int k) {
        int n = nums.length;
        int maxLen = 0;
        Map<Integer, Integer> count = new HashMap<>();
        int left = 0;
        int removals = 0;

        for (int right = 0; right < n; right++) {
            int num = nums[right];
            count.put(num, count.getOrDefault(num, 0) + 1);

            removals = right - left + 1 - count.get(num);

            while (removals > k) {
                int leftNum = nums[left];
                count.put(leftNum, count.get(leftNum) - 1);
                left++;
                int currentMaxCount = 0;
                for(int val : count.keySet()){
                    currentMaxCount = Math.max(currentMaxCount, count.get(val));
                }
                removals = right - left + 1 - currentMaxCount;

            }
            int currentMaxCount = 0;
                for(int val : count.keySet()){
                    currentMaxCount = Math.max(currentMaxCount, count.get(val));
                }
            maxLen = Math.max(maxLen, currentMaxCount);
        }

        return maxLen;
    }
}