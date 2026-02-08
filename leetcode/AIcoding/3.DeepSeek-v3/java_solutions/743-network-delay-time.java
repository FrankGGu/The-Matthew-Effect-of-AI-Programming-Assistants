class Solution {
    public int networkDelayTime(int[][] times, int n, int k) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] time : times) {
            int u = time[0], v = time[1], w = time[2];
            graph.putIfAbsent(u, new ArrayList<>());
            graph.get(u).add(new int[]{v, w});
        }

        PriorityQueue<int[]> heap = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        heap.offer(new int[]{k, 0});

        Map<Integer, Integer> dist = new HashMap<>();

        while (!heap.isEmpty()) {
            int[] node = heap.poll();
            int u = node[0], d = node[1];
            if (dist.containsKey(u)) continue;
            dist.put(u, d);
            if (graph.containsKey(u)) {
                for (int[] edge : graph.get(u)) {
                    int v = edge[0], w = edge[1];
                    if (!dist.containsKey(v)) {
                        heap.offer(new int[]{v, d + w});
                    }
                }
            }
        }

        if (dist.size() != n) return -1;
        int max = 0;
        for (int val : dist.values()) {
            max = Math.max(max, val);
        }
        return max;
    }
}