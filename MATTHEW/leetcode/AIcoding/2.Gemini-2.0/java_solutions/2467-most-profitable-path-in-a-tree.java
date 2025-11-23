import java.util.*;

class Solution {
    public int mostProfitablePath(int[][] edges, int bob, int[] amount) {
        int n = amount.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] parent = new int[n];
        Arrays.fill(parent, -1);
        Queue<Integer> q = new LinkedList<>();
        q.offer(0);
        parent[0] = 0;

        while (!q.isEmpty()) {
            int u = q.poll();
            for (int v : adj.get(u)) {
                if (parent[v] == -1) {
                    parent[v] = u;
                    q.offer(v);
                }
            }
        }

        int[] bobPath = new int[n];
        Arrays.fill(bobPath, -1);
        int bobDist = 0;
        int curr = bob;
        while (curr != 0) {
            bobPath[curr] = bobDist++;
            curr = parent[curr];
        }
        bobPath[0] = bobDist;

        int[] aliceDist = new int[n];
        Arrays.fill(aliceDist, -1);
        aliceDist[0] = 0;
        q = new LinkedList<>();
        q.offer(0);

        while (!q.isEmpty()) {
            int u = q.poll();
            for (int v : adj.get(u)) {
                if (aliceDist[v] == -1) {
                    aliceDist[v] = aliceDist[u] + 1;
                    q.offer(v);
                }
            }
        }

        for (int i = 0; i < n; i++) {
            if (aliceDist[i] != -1 && bobPath[i] != -1) {
                if (aliceDist[i] < bobPath[i]) {
                    // do nothing
                } else if (aliceDist[i] == bobPath[i]) {
                    amount[i] /= 2;
                } else {
                    amount[i] = 0;
                }
            }
        }

        int maxProfit = Integer.MIN_VALUE;
        q = new LinkedList<>();
        q.offer(0);
        boolean[] visited = new boolean[n];
        visited[0] = true;

        while (!q.isEmpty()) {
            int u = q.poll();
            boolean isLeaf = true;
            for (int v : adj.get(u)) {
                if (!visited[v]) {
                    visited[v] = true;
                    amount[v] += amount[u];
                    q.offer(v);
                    isLeaf = false;
                }
            }
            if (isLeaf) {
                maxProfit = Math.max(maxProfit, amount[u]);
            }
        }

        return maxProfit;
    }
}