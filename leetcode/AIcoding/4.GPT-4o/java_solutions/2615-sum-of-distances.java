import java.util.*;

public class Solution {
    public int[] sumOfDistancesInTree(int N, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < N; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] count = new int[N];
        int[] res = new int[N];
        Arrays.fill(count, 1);

        dfs1(0, -1, graph, count, res);
        dfs2(0, -1, graph, count, res, N);

        return res;
    }

    private void dfs1(int node, int parent, List<List<Integer>> graph, int[] count, int[] res) {
        for (int neighbor : graph.get(node)) {
            if (neighbor == parent) continue;
            dfs1(neighbor, node, graph, count, res);
            count[node] += count[neighbor];
            res[node] += res[neighbor] + count[neighbor];
        }
    }

    private void dfs2(int node, int parent, List<List<Integer>> graph, int[] count, int[] res, int N) {
        for (int neighbor : graph.get(node)) {
            if (neighbor == parent) continue;
            res[neighbor] = res[node] - count[neighbor] + (N - count[neighbor]);
            dfs2(neighbor, node, graph, count, res, N);
        }
    }
}