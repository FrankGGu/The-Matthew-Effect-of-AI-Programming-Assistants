import java.util.HashMap;
import java.util.Map;

class Solution {
    public int findPairs(int[] nums, int k) {
        if (nums == null || nums.length == 0 || k < 0) {
            return 0;
        }

        Map<Integer, Integer> map = new HashMap<>();
        int count = 0;

        for (int num : nums) {
            map.put(num, map.getOrDefault(num, 0) + 1);
        }

        for (int key : map.keySet()) {
            if (k == 0) {
                if (map.get(key) > 1) {
                    count++;
                }
            } else {
                if (map.containsKey(key + k)) {
                    count++;
                }
            }
        }

        return count;
    }
}