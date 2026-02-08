class Solution {
    public int maximumInvitations(int[] favorite) {
        int n = favorite.length;
        int[] inDegree = new int[n];
        for (int f : favorite) {
            inDegree[f]++;
        }

        int[] maxDepth = new int[n];
        boolean[] visited = new boolean[n];
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
                visited[i] = true;
            }
        }

        while (!queue.isEmpty()) {
            int u = queue.poll();
            int v = favorite[u];
            maxDepth[v] = Math.max(maxDepth[v], maxDepth[u] + 1);
            if (--inDegree[v] == 0) {
                visited[v] = true;
                queue.offer(v);
            }
        }

        int total = 0;
        int maxCycle = 0;
        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int cycleLength = 0;
                int j = i;
                while (!visited[j]) {
                    visited[j] = true;
                    j = favorite[j];
                    cycleLength++;
                }
                if (cycleLength == 2) {
                    total += 2 + maxDepth[i] + maxDepth[favorite[i]];
                } else {
                    maxCycle = Math.max(maxCycle, cycleLength);
                }
            }
        }

        return Math.max(total, maxCycle);
    }
}