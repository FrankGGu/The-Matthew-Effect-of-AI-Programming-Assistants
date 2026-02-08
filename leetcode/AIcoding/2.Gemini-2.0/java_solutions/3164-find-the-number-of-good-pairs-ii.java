import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numberOfGoodPairs(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        int result = 0;
        for (int num : nums) {
            if (count.containsKey(num)) {
                result += count.get(num);
                count.put(num, count.get(num) + 1);
            } else {
                count.put(num, 1);
            }
        }
        return result;
    }
}