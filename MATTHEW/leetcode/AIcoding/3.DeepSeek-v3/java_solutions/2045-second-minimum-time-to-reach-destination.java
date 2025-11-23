class Solution {
    public int secondMinimum(int n, int[][] edges, int time, int change) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] first = new int[n + 1];
        int[] second = new int[n + 1];
        Arrays.fill(first, Integer.MAX_VALUE);
        Arrays.fill(second, Integer.MAX_VALUE);
        first[1] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        pq.offer(new int[]{1, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0];
            int currTime = curr[1];

            if (currTime > second[node]) continue;

            for (int neighbor : graph.get(node)) {
                int nextTime = currTime;
                int cycles = nextTime / change;
                if (cycles % 2 == 1) {
                    nextTime = (cycles + 1) * change;
                }
                nextTime += time;

                if (nextTime < first[neighbor]) {
                    second[neighbor] = first[neighbor];
                    first[neighbor] = nextTime;
                    pq.offer(new int[]{neighbor, nextTime});
                } else if (nextTime > first[neighbor] && nextTime < second[neighbor]) {
                    second[neighbor] = nextTime;
                    pq.offer(new int[]{neighbor, nextTime});
                }
            }
        }

        return second[n];
    }
}