public class Solution {

import java.util.*;

public class Solution {
    public int countPalindromePaths(int[] nums, int[][] edges) {
        int n = nums.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        int[] xor = new int[n];
        boolean[] visited = new boolean[n];
        dfs(0, -1, nums, graph, xor, visited);

        Map<Integer, Integer> freq = new HashMap<>();
        freq.put(xor[0], 1);

        int result = 0;
        for (int i = 1; i < n; i++) {
            int mask = xor[i];
            for (int j = 0; j < 10; j++) {
                int temp = mask ^ (1 << j);
                result += freq.getOrDefault(temp, 0);
            }
            result += freq.getOrDefault(mask, 0);
            freq.put(mask, freq.getOrDefault(mask, 0) + 1);
        }

        return result;
    }

    private void dfs(int node, int parent, int[] nums, List<List<Integer>> graph, int[] xor, boolean[] visited) {
        visited[node] = true;
        xor[node] = nums[node];
        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                dfs(neighbor, node, nums, graph, xor, visited);
                xor[node] ^= xor[neighbor];
            }
        }
    }
}
}