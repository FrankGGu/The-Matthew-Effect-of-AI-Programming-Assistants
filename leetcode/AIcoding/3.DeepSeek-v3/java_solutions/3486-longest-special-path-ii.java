class Solution {
    public int longestCycle(int[] edges) {
        int n = edges.length;
        int[] visited = new int[n];
        int maxCycle = -1;
        for (int i = 0; i < n; i++) {
            if (visited[i] == 0) {
                int current = i;
                int start = i;
                int step = 1;
                while (current != -1 && visited[current] == 0) {
                    visited[current] = step++;
                    current = edges[current];
                }
                if (current != -1 && visited[current] >= visited[start]) {
                    maxCycle = Math.max(maxCycle, step - visited[current]);
                }
            }
        }
        return maxCycle;
    }
}