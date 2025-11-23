public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> getCoprimesCount(int n, int[] edges, int[] queries) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.computeIfAbsent(edge[0], k -> new ArrayList<>()).add(edge[1]);
            graph.computeIfAbsent(edge[1], k -> new ArrayList<>()).add(edge[0]);
        }

        int[] depth = new int[n];
        int[][] parent = new int[n][20];
        int[] inTime = new int[n];
        int[] outTime = new int[n];
        int time = 0;

        dfs(0, -1, 0, graph, depth, parent, inTime, outTime, time);

        int[][] freq = new int[1001][20];
        List<Integer> result = new ArrayList<>();

        for (int q : queries) {
            int res = 0;
            int node = q;
            for (int i = 19; i >= 0; i--) {
                if (parent[node][i] != -1) {
                    int p = parent[node][i];
                    for (int j = 1; j <= 1000; j++) {
                        if (gcd(j, depth[node] - depth[p]) == 1) {
                            res += freq[j][i];
                        }
                    }
                    node = p;
                }
            }
            result.add(res);
        }

        return result;
    }

    private void dfs(int node, int p, int d, Map<Integer, List<Integer>> graph, int[] depth, int[][] parent, int[] inTime, int[] outTime, int time) {
        depth[node] = d;
        parent[node][0] = p;
        inTime[node] = time++;
        for (int i = 1; i < 20; i++) {
            if (parent[node][i - 1] != -1) {
                parent[node][i] = parent[parent[node][i - 1]][i - 1];
            } else {
                parent[node][i] = -1;
            }
        }
        for (int neighbor : graph.getOrDefault(node, Collections.emptyList())) {
            if (neighbor != p) {
                dfs(neighbor, node, d + 1, graph, depth, parent, inTime, outTime, time);
            }
        }
        outTime[node] = time++;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}
}