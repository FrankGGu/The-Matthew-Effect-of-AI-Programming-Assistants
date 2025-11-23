import java.util.*;

class Solution {
    public List<Integer> findLonely(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        List<Integer> result = new ArrayList<>();
        for (int num : nums) {
            if (count.get(num) == 1 && !count.containsKey(num - 1) && !count.containsKey(num + 1)) {
                result.add(num);
            }
        }
        return result;
    }
}