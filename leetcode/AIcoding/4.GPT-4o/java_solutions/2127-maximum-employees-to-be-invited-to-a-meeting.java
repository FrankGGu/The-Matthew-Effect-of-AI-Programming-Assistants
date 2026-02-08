import java.util.*;

public class Solution {
    public int maxEmployees(int[][] relations) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        int[] inDegree = new int[relations.length];

        for (int[] relation : relations) {
            int u = relation[0] - 1;
            int v = relation[1] - 1;
            graph.putIfAbsent(u, new ArrayList<>());
            graph.get(u).add(v);
            inDegree[v]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < inDegree.length; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
            }
        }

        int count = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            count += size;
            for (int i = 0; i < size; i++) {
                int node = queue.poll();
                for (int neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                    inDegree[neighbor]--;
                    if (inDegree[neighbor] == 0) {
                        queue.offer(neighbor);
                    }
                }
            }
        }

        return count;
    }
}