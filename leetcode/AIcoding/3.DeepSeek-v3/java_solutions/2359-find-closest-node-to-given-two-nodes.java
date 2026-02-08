class Solution {
    public int closestMeetingNode(int[] edges, int node1, int node2) {
        int n = edges.length;
        int[] dist1 = new int[n];
        int[] dist2 = new int[n];
        Arrays.fill(dist1, -1);
        Arrays.fill(dist2, -1);
        dist1[node1] = 0;
        dist2[node2] = 0;

        dfs(node1, edges, dist1);
        dfs(node2, edges, dist2);

        int minDist = Integer.MAX_VALUE;
        int result = -1;

        for (int i = 0; i < n; i++) {
            if (dist1[i] != -1 && dist2[i] != -1) {
                int currentMax = Math.max(dist1[i], dist2[i]);
                if (currentMax < minDist) {
                    minDist = currentMax;
                    result = i;
                }
            }
        }

        return result;
    }

    private void dfs(int node, int[] edges, int[] dist) {
        int neighbor = edges[node];
        if (neighbor != -1 && dist[neighbor] == -1) {
            dist[neighbor] = dist[node] + 1;
            dfs(neighbor, edges, dist);
        }
    }
}