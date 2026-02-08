class Solution {
    public int closestMeetingNode(int[] edges, int node1, int node2) {
        int n = edges.length;
        int[] dist1 = new int[n];
        int[] dist2 = new int[n];

        Arrays.fill(dist1, Integer.MAX_VALUE);
        Arrays.fill(dist2, Integer.MAX_VALUE);

        bfs(edges, node1, dist1);
        bfs(edges, node2, dist2);

        int minDist = Integer.MAX_VALUE;
        int result = -1;

        for (int i = 0; i < n; i++) {
            int maxDist = Math.max(dist1[i], dist2[i]);
            if (maxDist < minDist) {
                minDist = maxDist;
                result = i;
            }
        }

        return result;
    }

    private void bfs(int[] edges, int start, int[] dist) {
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(start);
        dist[start] = 0;

        while (!queue.isEmpty()) {
            int node = queue.poll();
            int nextNode = edges[node];
            if (nextNode != -1 && dist[nextNode] == Integer.MAX_VALUE) {
                dist[nextNode] = dist[node] + 1;
                queue.offer(nextNode);
            }
        }
    }
}