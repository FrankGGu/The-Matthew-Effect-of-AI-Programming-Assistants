import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public int findPairs(int[] nums, int k) {
        if (k < 0) {
            return 0;
        }

        if (k == 0) {
            Map<Integer, Integer> counts = new HashMap<>();
            for (int num : nums) {
                counts.put(num, counts.getOrDefault(num, 0) + 1);
            }

            int result = 0;
            for (int num : counts.keySet()) {
                if (counts.get(num) > 1) {
                    result++;
                }
            }
            return result;
        } else { // k > 0
            Set<Integer> uniqueNums = new HashSet<>();
            for (int num : nums) {
                uniqueNums.add(num);
            }

            int result = 0;
            for (int num : uniqueNums) {
                if (uniqueNums.contains(num + k)) {
                    result++;
                }
            }
            return result;
        }
    }
}