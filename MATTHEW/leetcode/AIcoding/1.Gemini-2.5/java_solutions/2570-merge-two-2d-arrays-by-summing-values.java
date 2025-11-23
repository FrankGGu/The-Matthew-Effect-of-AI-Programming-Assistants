import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

class Solution {
    public List<List<Integer>> mergeArrays(int[][] nums1, int[][] nums2) {
        TreeMap<Integer, Integer> mergedMap = new TreeMap<>();

        for (int[] pair : nums1) {
            int id = pair[0];
            int val = pair[1];
            mergedMap.put(id, mergedMap.getOrDefault(id, 0) + val);
        }

        for (int[] pair : nums2) {
            int id = pair[0];
            int val = pair[1];
            mergedMap.put(id, mergedMap.getOrDefault(id, 0) + val);
        }

        List<List<Integer>> result = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : mergedMap.entrySet()) {
            List<Integer> currentPair = new ArrayList<>();
            currentPair.add(entry.getKey());
            currentPair.add(entry.getValue());
            result.add(currentPair);
        }

        return result;
    }
}