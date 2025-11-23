import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<Integer> findLonely(int[] nums) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        List<Integer> lonelyNumbers = new ArrayList<>();
        for (int num : nums) {
            if (countMap.get(num) == 1 && !countMap.containsKey(num - 1) && !countMap.containsKey(num + 1)) {
                lonelyNumbers.add(num);
            }
        }

        return lonelyNumbers;
    }
}