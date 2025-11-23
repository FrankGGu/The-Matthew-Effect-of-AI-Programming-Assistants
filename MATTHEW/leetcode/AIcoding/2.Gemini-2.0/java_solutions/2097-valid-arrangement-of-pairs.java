import java.util.*;

class Solution {
    public int[][] validArrangement(int[][] pairs) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        Map<Integer, Integer> inDegree = new HashMap<>();
        Map<Integer, Integer> outDegree = new HashMap<>();

        Set<Integer> nodes = new HashSet<>();

        for (int[] pair : pairs) {
            int u = pair[0];
            int v = pair[1];

            graph.computeIfAbsent(u, k -> new ArrayList<>()).add(v);

            inDegree.put(v, inDegree.getOrDefault(v, 0) + 1);
            outDegree.put(u, outDegree.getOrDefault(u, 0) + 1);

            nodes.add(u);
            nodes.add(v);
        }

        int start = -1;
        for (int node : nodes) {
            int in = inDegree.getOrDefault(node, 0);
            int out = outDegree.getOrDefault(node, 0);

            if (out - in == 1) {
                start = node;
                break;
            }
        }

        if (start == -1) {
            start = pairs[0][0];
        }

        List<int[]> result = new ArrayList<>();
        dfs(start, graph, result);

        Collections.reverse(result);
        return result.toArray(new int[result.size()][]);
    }

    private void dfs(int u, Map<Integer, List<Integer>> graph, List<int[]> result) {
        while (graph.containsKey(u) && !graph.get(u).isEmpty()) {
            int v = graph.get(u).remove(0);
            result.add(new int[]{u, v});
            dfs(v, graph, result);
        }
    }
}