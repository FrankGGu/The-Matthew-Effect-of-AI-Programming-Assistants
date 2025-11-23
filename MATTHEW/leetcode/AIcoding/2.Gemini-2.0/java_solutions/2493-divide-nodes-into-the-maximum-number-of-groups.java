import java.util.*;

class Solution {
    public int magnificentSets(int n, int[][] edges) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0] - 1;
            int v = edge[1] - 1;
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        int[] color = new int[n];
        Arrays.fill(color, 0);
        int maxGroups = 0;
        List<Integer> components = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (color[i] == 0) {
                components.add(i);
            }
        }

        for (int startNode : components) {
            int componentMaxGroups = 0;
            Queue<Integer> q = new LinkedList<>();
            q.offer(startNode);
            color[startNode] = 1;
            int[] dist = new int[n];
            Arrays.fill(dist, -1);
            dist[startNode] = 1;
            boolean isBipartite = true;

            while (!q.isEmpty()) {
                int u = q.poll();
                componentMaxGroups = Math.max(componentMaxGroups, dist[u]);

                for (int v : adj.get(u)) {
                    if (color[v] == 0) {
                        color[v] = 3 - color[u];
                        dist[v] = dist[u] + 1;
                        q.offer(v);
                    } else if (color[v] == color[u]) {
                        isBipartite = false;
                        break;
                    }
                }
                if (!isBipartite) break;
            }
            if (!isBipartite) return -1;
            maxGroups += componentMaxGroups;

            for(int i=0; i<n; ++i){
                if(dist[i]!=-1){
                    color[i] = 0;
                }
            }

            for(int i=0; i<n; ++i){
                if(adj.get(i).size() > 0 && color[i] == 0){
                    Queue<Integer> q2 = new LinkedList<>();
                    q2.offer(i);
                    color[i] = 1;
                    int[] dist2 = new int[n];
                    Arrays.fill(dist2, -1);
                    dist2[i] = 1;
                    boolean isBipartite2 = true;
                    int localMaxGroups = 0;

                    while (!q2.isEmpty()) {
                        int u = q2.poll();
                        localMaxGroups = Math.max(localMaxGroups, dist2[u]);

                        for (int v : adj.get(u)) {
                            if (color[v] == 0) {
                                color[v] = 3 - color[u];
                                dist2[v] = dist2[u] + 1;
                                q2.offer(v);
                            } else if (color[v] == color[u]) {
                                isBipartite2 = false;
                                break;
                            }
                        }
                        if (!isBipartite2) break;
                    }
                    if (!isBipartite2) return -1;
                    maxGroups += localMaxGroups;

                    for(int j=0; j<n; ++j){
                        if(dist2[j]!=-1){
                            color[j] = 0;
                        }
                    }
                }
            }
        }
        return maxGroups;
    }
}