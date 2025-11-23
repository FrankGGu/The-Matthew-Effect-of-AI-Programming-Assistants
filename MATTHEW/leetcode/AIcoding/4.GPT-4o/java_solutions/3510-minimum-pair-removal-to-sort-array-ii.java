import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int minPairRemovals(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        int pairs = 0;
        for (int v : count.values()) {
            pairs += v / 2;
        }

        return nums.length - 2 * pairs;
    }
}