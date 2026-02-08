import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

class Solution {
    public List<List<Integer>> mergeSimilarItems(int[][] items1, int[][] items2) {
        Map<Integer, Integer> mergedItems = new TreeMap<>();

        for (int[] item : items1) {
            mergedItems.put(item[0], mergedItems.getOrDefault(item[0], 0) + item[1]);
        }

        for (int[] item : items2) {
            mergedItems.put(item[0], mergedItems.getOrDefault(item[0], 0) + item[1]);
        }

        List<List<Integer>> result = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : mergedItems.entrySet()) {
            result.add(List.of(entry.getKey(), entry.getValue()));
        }

        return result;
    }
}