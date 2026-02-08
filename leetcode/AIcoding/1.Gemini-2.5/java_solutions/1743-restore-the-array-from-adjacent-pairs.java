import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int[] restoreArray(int[][] adjacentPairs) {
        Map<Integer, List<Integer>> adj = new HashMap<>();
        for (int[] pair : adjacentPairs) {
            adj.computeIfAbsent(pair[0], k -> new ArrayList<>()).add(pair[1]);
            adj.computeIfAbsent(pair[1], k -> new ArrayList<>()).add(pair[0]);
        }

        int n = adjacentPairs.length + 1;
        int[] result = new int[n];

        int start = -1;
        for (Map.Entry<Integer, List<Integer>> entry : adj.entrySet()) {
            if (entry.getValue().size() == 1) {
                start = entry.getKey();
                break;
            }
        }

        result[0] = start;
        result[1] = adj.get(start).get(0);

        int prev = start;
        int current = result[1];

        for (int i = 2; i < n; i++) {
            List<Integer> neighbors = adj.get(current);
            int next;
            if (neighbors.get(0) == prev) {
                next = neighbors.get(1);
            } else {
                next = neighbors.get(0);
            }
            result[i] = next;
            prev = current;
            current = next;
        }

        return result;
    }
}