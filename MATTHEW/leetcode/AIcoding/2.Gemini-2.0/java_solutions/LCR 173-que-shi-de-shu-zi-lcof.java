import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[] attendanceRecord(int n, int[] record) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int id : record) {
            countMap.put(id, countMap.getOrDefault(id, 0) + 1);
        }

        int[] result = new int[n];
        Arrays.fill(result, 0);

        for (int id : countMap.keySet()) {
            if (id <= n) {
                result[id - 1] = countMap.get(id);
            }
        }

        return result;
    }
}