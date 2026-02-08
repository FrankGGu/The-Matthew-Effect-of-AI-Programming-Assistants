import java.util.*;

class Solution {
    public int findMinHeightTrees(int n, int[][] edges) {
        if (n == 1) return Collections.singletonList(0);

        List<Set<Integer>> adj = new ArrayList<>(n);
        for (int i = 0; i < n; ++i) adj.add(new HashSet<>());

        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        List<Integer> leaves = new ArrayList<>();
        for (int i = 0; i < n; ++i) {
            if (adj.get(i).size() == 1) leaves.add(i);
        }

        while (n > 2) {
            n -= leaves.size();
            List<Integer> newLeaves = new ArrayList<>();

            for (int i : leaves) {
                int neighbor = adj.get(i).iterator().next();
                adj.get(neighbor).remove(i);
                if (adj.get(neighbor).size() == 1) newLeaves.add(neighbor);
            }

            leaves = newLeaves;
        }

        return leaves;
    }

    public int findMinDiameter(int n, int[][] edges, int n2, int[][] edges2) {
        List<Set<Integer>> adj1 = new ArrayList<>(n);
        for (int i = 0; i < n; ++i) adj1.add(new HashSet<>());

        for (int[] edge : edges) {
            adj1.get(edge[0]).add(edge[1]);
            adj1.get(edge[1]).add(edge[0]);
        }

        List<Set<Integer>> adj2 = new ArrayList<>(n2);
        for (int i = 0; i < n2; ++i) adj2.add(new HashSet<>());

        for (int[] edge : edges2) {
            adj2.get(edge[0]).add(edge[1]);
            adj2.get(edge[1]).add(edge[0]);
        }

        int diameter1 = getDiameter(n, adj1);
        int diameter2 = getDiameter(n2, adj2);

        List<Integer> centers1 = findMinHeightTrees(n, edges);
        List<Integer> centers2 = findMinHeightTrees(n2, edges2);

        int minDiameter = Integer.MAX_VALUE;
        for (int center1 : centers1) {
            for (int center2 : centers2) {
                int maxDist1 = 0;
                for (int i = 0; i < n; i++) {
                    maxDist1 = Math.max(maxDist1, bfs(n, adj1, center1, i));
                }

                int maxDist2 = 0;
                for (int i = 0; i < n2; i++) {
                    maxDist2 = Math.max(maxDist2, bfs(n2, adj2, center2, i));
                }

                int distBetweenCenters = maxDist1 + maxDist2 + 1;
                minDiameter = Math.min(minDiameter, Math.max(distBetweenCenters, Math.max(diameter1, diameter2)));
            }
        }
        return minDiameter;
    }

    private int bfs(int n, List<Set<Integer>> adj, int start, int end) {
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(start);
        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        dist[start] = 0;

        while (!queue.isEmpty()) {
            int u = queue.poll();
            if (u == end) return dist[u];

            for (int v : adj.get(u)) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    queue.offer(v);
                }
            }
        }

        return dist[end];
    }

    private int getDiameter(int n, List<Set<Integer>> adj) {
        int end1 = bfsFurthestNode(n, adj, 0);
        int end2 = bfsFurthestNode(n, adj, end1);
        return bfs(n, adj, end1, end2);
    }

    private int bfsFurthestNode(int n, List<Set<Integer>> adj, int start) {
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(start);
        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        dist[start] = 0;
        int lastNode = start;

        while (!queue.isEmpty()) {
            int u = queue.poll();
            lastNode = u;

            for (int v : adj.get(u)) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    queue.offer(v);
                }
            }
        }

        return lastNode;
    }
}