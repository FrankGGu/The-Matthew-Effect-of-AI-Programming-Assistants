import java.util.*;

class Solution {
    public int largestPathValue(String colors, int[][] edges) {
        int n = colors.length();
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        int[] indegree = new int[n];
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            indegree[edge[1]]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (indegree[i] == 0) {
                queue.offer(i);
            }
        }

        int[][] count = new int[n][26];
        for (int i = 0; i < n; i++) {
            count[i][colors.charAt(i) - 'a'] = 1;
        }

        int visited = 0;
        int ans = 0;

        while (!queue.isEmpty()) {
            int u = queue.poll();
            visited++;
            ans = Math.max(ans, Arrays.stream(count[u]).max().getAsInt());

            for (int v : adj.get(u)) {
                for (int i = 0; i < 26; i++) {
                    count[v][i] = Math.max(count[v][i], count[u][i] + (colors.charAt(v) - 'a' == i ? 1 : 0));
                }
                indegree[v]--;
                if (indegree[v] == 0) {
                    queue.offer(v);
                }
            }
        }

        return visited == n ? ans : -1;
    }
}