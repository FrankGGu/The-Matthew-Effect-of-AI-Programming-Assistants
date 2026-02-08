import java.util.HashMap;
import java.util.Map;

class Solution {
    public int findShortestSubArray(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        Map<Integer, Integer> first = new HashMap<>();
        Map<Integer, Integer> last = new HashMap<>();
        int degree = 0;
        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];
            count.put(num, count.getOrDefault(num, 0) + 1);
            degree = Math.max(degree, count.get(num));
            if (!first.containsKey(num)) {
                first.put(num, i);
            }
            last.put(num, i);
        }
        int minLen = nums.length;
        for (int num : count.keySet()) {
            if (count.get(num) == degree) {
                minLen = Math.min(minLen, last.get(num) - first.get(num) + 1);
            }
        }
        return minLen;
    }
}