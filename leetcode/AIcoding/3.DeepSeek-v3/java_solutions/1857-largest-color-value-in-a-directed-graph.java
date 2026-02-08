class Solution {
    public int largestPathValue(String colors, int[][] edges) {
        int n = colors.length();
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        int[] inDegree = new int[n];
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            inDegree[edge[1]]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
            }
        }

        int[][] count = new int[n][26];
        int visited = 0;
        int maxColor = 0;

        while (!queue.isEmpty()) {
            int u = queue.poll();
            visited++;
            int currentColor = colors.charAt(u) - 'a';
            count[u][currentColor]++;
            maxColor = Math.max(maxColor, count[u][currentColor]);

            for (int v : adj.get(u)) {
                for (int i = 0; i < 26; i++) {
                    count[v][i] = Math.max(count[v][i], count[u][i]);
                }
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    queue.offer(v);
                }
            }
        }

        return visited == n ? maxColor : -1;
    }
}