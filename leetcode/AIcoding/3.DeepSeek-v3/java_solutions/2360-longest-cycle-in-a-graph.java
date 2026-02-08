class Solution {
    public int longestCycle(int[] edges) {
        int n = edges.length;
        boolean[] visited = new boolean[n];
        int maxCycle = -1;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                Map<Integer, Integer> distance = new HashMap<>();
                distance.put(i, 0);
                int current = i;
                int step = 0;

                while (true) {
                    visited[current] = true;
                    int next = edges[current];
                    if (next == -1) break;

                    if (distance.containsKey(next)) {
                        maxCycle = Math.max(maxCycle, step - distance.get(next) + 1);
                        break;
                    }

                    if (visited[next]) break;

                    distance.put(next, ++step);
                    current = next;
                }
            }
        }

        return maxCycle;
    }
}