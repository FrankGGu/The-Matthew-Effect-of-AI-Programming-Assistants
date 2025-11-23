class Solution {
    public int minimumTime(int n, int[][] relations, int[] time) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        int[] inDegree = new int[n];
        for (int[] relation : relations) {
            int prev = relation[0] - 1;
            int next = relation[1] - 1;
            graph.get(prev).add(next);
            inDegree[next]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        int[] maxTime = new int[n];
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
                maxTime[i] = time[i];
            }
        }

        while (!queue.isEmpty()) {
            int u = queue.poll();
            for (int v : graph.get(u)) {
                maxTime[v] = Math.max(maxTime[v], maxTime[u] + time[v]);
                if (--inDegree[v] == 0) {
                    queue.offer(v);
                }
            }
        }

        int res = 0;
        for (int t : maxTime) {
            res = Math.max(res, t);
        }
        return res;
    }
}