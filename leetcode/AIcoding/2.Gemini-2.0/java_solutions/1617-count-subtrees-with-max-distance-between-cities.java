import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    private int[][] graph;
    private int n;
    private int maxDist;

    public int[] countSubtrees(int n, int[][] edges) {
        this.n = n;
        graph = new int[n][n];
        for (int[] edge : edges) {
            int u = edge[0] - 1;
            int v = edge[1] - 1;
            graph[u][v] = 1;
            graph[v][u] = 1;
        }

        int[] result = new int[n - 1];
        Arrays.fill(result, 0);

        for (int i = 1; i < (1 << n); i++) {
            List<Integer> nodes = new ArrayList<>();
            for (int j = 0; j < n; j++) {
                if ((i & (1 << j)) != 0) {
                    nodes.add(j);
                }
            }

            if (nodes.size() == 1) continue;

            boolean connected = false;
            for (int u : nodes) {
                for (int v : nodes) {
                    if (u != v && graph[u][v] == 1) {
                        connected = true;
                        break;
                    }
                }
                if (connected) break;
            }
            if (!connected) continue;

            boolean isSubtree = true;
            for(int u : nodes){
                for(int v : nodes){
                    if(u != v){
                        boolean pathExists = false;
                        boolean[] visited = new boolean[n];
                        List<Integer> queue = new ArrayList<>();
                        queue.add(u);
                        visited[u] = true;

                        while(!queue.isEmpty()){
                            int curr = queue.remove(0);
                            if(curr == v){
                                pathExists = true;
                                break;
                            }
                            for(int neighbor = 0; neighbor < n; neighbor++){
                                if(nodes.contains(neighbor) && graph[curr][neighbor] == 1 && !visited[neighbor]){
                                    queue.add(neighbor);
                                    visited[neighbor] = true;
                                }
                            }
                        }
                        if(!pathExists){
                            isSubtree = false;
                            break;
                        }
                    }
                }
                if(!isSubtree) break;
            }
            if(!isSubtree) continue;

            maxDist = 0;
            for (int u : nodes) {
                for (int v : nodes) {
                    if (u != v) {
                        maxDist = Math.max(maxDist, bfs(u, v, nodes));
                    }
                }
            }

            result[maxDist - 1]++;
        }

        return result;
    }

    private int bfs(int start, int end, List<Integer> nodes) {
        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        dist[start] = 0;

        List<Integer> queue = new ArrayList<>();
        queue.add(start);

        while (!queue.isEmpty()) {
            int u = queue.remove(0);
            if (u == end) break;

            for (int v = 0; v < n; v++) {
                if (nodes.contains(v) && graph[u][v] == 1 && dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    queue.add(v);
                }
            }
        }

        return dist[end];
    }
}