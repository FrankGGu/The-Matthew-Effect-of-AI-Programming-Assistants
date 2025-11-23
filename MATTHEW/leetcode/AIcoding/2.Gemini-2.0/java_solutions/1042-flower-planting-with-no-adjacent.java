class Solution {
    public int[] gardenNoAdj(int n, int[][] paths) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] path : paths) {
            int u = path[0] - 1;
            int v = path[1] - 1;
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        int[] colors = new int[n];
        for (int i = 0; i < n; i++) {
            boolean[] used = new boolean[5];
            for (int neighbor : adj.get(i)) {
                if (colors[neighbor] != 0) {
                    used[colors[neighbor]] = true;
                }
            }
            for (int c = 1; c <= 4; c++) {
                if (!used[c]) {
                    colors[i] = c;
                    break;
                }
            }
        }

        return colors;
    }
}