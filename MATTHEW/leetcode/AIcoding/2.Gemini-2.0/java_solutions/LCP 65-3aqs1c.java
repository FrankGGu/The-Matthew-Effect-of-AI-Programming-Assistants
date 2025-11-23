class Solution {
    public int[] gardenNoAdj(int n, int[][] paths) {
        List<Integer>[] adj = new List[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }
        for (int[] path : paths) {
            int u = path[0] - 1;
            int v = path[1] - 1;
            adj[u].add(v);
            adj[v].add(u);
        }

        int[] colors = new int[n];
        for (int i = 0; i < n; i++) {
            boolean[] usedColors = new boolean[5];
            for (int neighbor : adj[i]) {
                if (colors[neighbor] != 0) {
                    usedColors[colors[neighbor]] = true;
                }
            }
            for (int color = 1; color <= 4; color++) {
                if (!usedColors[color]) {
                    colors[i] = color;
                    break;
                }
            }
        }

        return colors;
    }
}