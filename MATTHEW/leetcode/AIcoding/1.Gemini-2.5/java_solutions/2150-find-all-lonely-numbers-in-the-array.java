import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<Integer> findLonely(int[] nums) {
        Map<Integer, Integer> counts = new HashMap<>();
        for (int num : nums) {
            counts.put(num, counts.getOrDefault(num, 0) + 1);
        }

        List<Integer> lonelyNumbers = new ArrayList<>();
        for (int num : nums) {
            if (counts.get(num) == 1) {
                if (!counts.containsKey(num - 1) && !counts.containsKey(num + 1)) {
                    lonelyNumbers.add(num);
                }
            }
        }

        return lonelyNumbers;
    }
}