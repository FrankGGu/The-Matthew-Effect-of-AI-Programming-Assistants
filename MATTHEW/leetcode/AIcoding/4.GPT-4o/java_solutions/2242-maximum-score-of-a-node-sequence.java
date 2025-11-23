import java.util.*;

public class Solution {
    public int maximumScore(int[] scores, int[][] edges) {
        int n = scores.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int maxScore = -1;
        for (int i = 0; i < n; i++) {
            List<int[]> neighbors = new ArrayList<>();
            for (int neighbor : graph.get(i)) {
                neighbors.add(new int[]{neighbor, scores[neighbor]});
            }
            neighbors.sort((a, b) -> Integer.compare(b[1], a[1]));
            if (neighbors.size() >= 2) {
                for (int j = 0; j < neighbors.size() - 1; j++) {
                    for (int k = j + 1; k < neighbors.size(); k++) {
                        if (!isConnected(neighbors.get(j)[0], neighbors.get(k)[0], graph)) {
                            maxScore = Math.max(maxScore, scores[i] + neighbors.get(j)[1] + neighbors.get(k)[1]);
                        }
                    }
                }
            }
        }
        return maxScore;
    }

    private boolean isConnected(int a, int b, List<List<Integer>> graph) {
        return graph.get(a).contains(b);
    }
}