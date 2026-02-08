import java.util.*;

class Solution {
    public int[] restoreArray(int[][] adjacentPairs) {
        Map<Integer, List<Integer>> adj = new HashMap<>();
        for (int[] pair : adjacentPairs) {
            adj.computeIfAbsent(pair[0], k -> new ArrayList<>()).add(pair[1]);
            adj.computeIfAbsent(pair[1], k -> new ArrayList<>()).add(pair[0]);
        }

        int start = 0;
        for (int num : adj.keySet()) {
            if (adj.get(num).size() == 1) {
                start = num;
                break;
            }
        }

        int[] result = new int[adjacentPairs.length + 1];
        result[0] = start;
        int prev = Integer.MAX_VALUE;
        for (int i = 1; i < result.length; i++) {
            for (int neighbor : adj.get(result[i - 1])) {
                if (neighbor != prev) {
                    result[i] = neighbor;
                    prev = result[i - 1];
                    break;
                }
            }
        }

        return result;
    }
}