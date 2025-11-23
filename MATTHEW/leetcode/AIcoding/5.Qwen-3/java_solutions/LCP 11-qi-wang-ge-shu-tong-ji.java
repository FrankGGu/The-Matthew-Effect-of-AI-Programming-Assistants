public class Solution {

import java.util.*;

public class Solution {
    public int[] expectNumber(int[] scan, int[] record) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : scan) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }
        int[] result = new int[record.length];
        for (int i = 0; i < record.length; i++) {
            result[i] = countMap.getOrDefault(record[i], 0);
        }
        return result;
    }
}
}