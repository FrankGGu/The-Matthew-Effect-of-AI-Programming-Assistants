public class Solution {

import java.util.*;

public class Solution {
    public int componentValue(int[] nums, int[] edges) {
        int n = nums.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int total = Arrays.stream(nums).sum();
        Set<Integer> candidates = new HashSet<>();
        for (int i = 1; i * i <= total; i++) {
            if (total % i == 0) {
                candidates.add(i);
                candidates.add(total / i);
            }
        }

        Collections.sort((List<Integer>) candidates, Collections.reverseOrder());

        for (int candidate : candidates) {
            if (candidate == 0) continue;
            boolean[] visited = new boolean[n];
            int count = 0;
            for (int i = 0; i < n; i++) {
                if (!visited[i]) {
                    int sum = dfs(i, -1, nums, graph, visited);
                    if (sum == candidate) {
                        count++;
                    } else if (sum > candidate) {
                        break;
                    }
                }
            }
            if (count >= 2 && total % candidate == 0) {
                return candidate;
            }
        }
        return 0;
    }

    private int dfs(int node, int parent, int[] nums, List<List<Integer>> graph, boolean[] visited) {
        visited[node] = true;
        int sum = nums[node];
        for (int neighbor : graph.get(node)) {
            if (neighbor != parent) {
                sum += dfs(neighbor, node, nums, graph, visited);
            }
        }
        return sum;
    }
}
}