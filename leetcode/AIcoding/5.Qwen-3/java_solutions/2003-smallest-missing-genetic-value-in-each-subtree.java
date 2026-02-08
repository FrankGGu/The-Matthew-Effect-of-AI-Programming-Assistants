public class Solution {

import java.util.*;

public class Solution {
    public int[] smallestMissingGrowth(int[] parents, int[] genes) {
        int n = parents.length;
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int i = 0; i < n; i++) {
            graph.putIfAbsent(parents[i], new ArrayList<>());
            graph.get(parents[i]).add(i);
        }

        int[] result = new int[n];
        Arrays.fill(result, 1);

        int[] geneMap = new int[n];
        for (int i = 0; i < n; i++) {
            geneMap[i] = genes[i];
        }

        Set<Integer> visited = new HashSet<>();
        Queue<Integer> queue = new LinkedList<>();

        for (int i = 0; i < n; i++) {
            if (genes[i] == 1) {
                queue.add(i);
                visited.add(i);
                break;
            }
        }

        while (!queue.isEmpty()) {
            int node = queue.poll();
            int currentGene = geneMap[node];
            if (currentGene != 1) {
                int missing = 1;
                while (missing <= currentGene) {
                    if (missing == currentGene) {
                        missing++;
                    } else {
                        break;
                    }
                }
                result[node] = missing;
            } else {
                result[node] = 1;
            }

            for (int child : graph.getOrDefault(node, new ArrayList<>())) {
                if (!visited.contains(child)) {
                    visited.add(child);
                    queue.add(child);
                }
            }
        }

        return result;
    }
}
}