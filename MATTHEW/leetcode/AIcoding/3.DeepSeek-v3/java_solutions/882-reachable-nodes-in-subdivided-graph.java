class Solution {
    public int reachableNodes(int[][] edges, int maxMoves, int n) {
        Map<Integer, Map<Integer, Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph.computeIfAbsent(u, x -> new HashMap<>()).put(v, w);
            graph.computeIfAbsent(v, x -> new HashMap<>()).put(u, w);
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> (b[1] - a[1]));
        pq.offer(new int[]{0, maxMoves});
        Map<Integer, Integer> visited = new HashMap<>();

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0], moves = curr[1];
            if (visited.containsKey(node)) continue;
            visited.put(node, moves);
            if (graph.containsKey(node)) {
                for (Map.Entry<Integer, Integer> entry : graph.get(node).entrySet()) {
                    int neighbor = entry.getKey(), weight = entry.getValue();
                    int remainingMoves = moves - weight - 1;
                    if (!visited.containsKey(neighbor) && remainingMoves >= 0) {
                        pq.offer(new int[]{neighbor, remainingMoves});
                    }
                }
            }
        }

        int res = visited.size();
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            int uv = visited.getOrDefault(u, 0);
            int vu = visited.getOrDefault(v, 0);
            res += Math.min(w, uv + vu);
        }
        return res;
    }
}