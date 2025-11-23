class Solution {
    public int minCost(int maxTime, int[][] edges, int[] passingFees) {
        int n = passingFees.length;
        List<int[]>[] graph = new List[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], time = edge[2];
            graph[u].add(new int[]{v, time});
            graph[v].add(new int[]{u, time});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        pq.offer(new int[]{0, passingFees[0], 0});

        int[][] costTime = new int[n][maxTime + 1];
        for (int i = 0; i < n; i++) {
            Arrays.fill(costTime[i], Integer.MAX_VALUE);
        }
        costTime[0][0] = passingFees[0];

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int node = current[0], cost = current[1], time = current[2];

            if (node == n - 1) {
                return cost;
            }

            for (int[] neighbor : graph[node]) {
                int nextNode = neighbor[0], nextTime = time + neighbor[1];
                if (nextTime > maxTime) {
                    continue;
                }
                int nextCost = cost + passingFees[nextNode];
                if (nextCost < costTime[nextNode][nextTime]) {
                    costTime[nextNode][nextTime] = nextCost;
                    pq.offer(new int[]{nextNode, nextCost, nextTime});
                }
            }
        }

        return -1;
    }
}