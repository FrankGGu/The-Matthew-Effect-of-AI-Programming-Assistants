public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int findLucky(int[] arr) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : arr) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }
        for (Map.Entry<Integer, Integer> entry : countMap.entrySet()) {
            if (entry.getKey() == entry.getValue()) {
                return entry.getKey();
            }
        }
        return -1;
    }
}
}