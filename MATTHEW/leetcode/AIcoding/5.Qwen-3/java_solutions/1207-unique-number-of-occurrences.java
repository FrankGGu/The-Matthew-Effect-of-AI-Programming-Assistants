public class Solution {

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class Solution {
    public boolean uniqueOccurrences(int[] arr) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : arr) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }
        Set<Integer> occurrenceSet = new HashSet<>();
        for (int count : countMap.values()) {
            if (occurrenceSet.contains(count)) {
                return false;
            }
            occurrenceSet.add(count);
        }
        return true;
    }
}
}