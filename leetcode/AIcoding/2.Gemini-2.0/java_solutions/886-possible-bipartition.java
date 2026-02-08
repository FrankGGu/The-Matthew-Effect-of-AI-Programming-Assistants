class Solution {
    public boolean possibleBipartition(int n, int[][] dislikes) {
        int[] colors = new int[n + 1];
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] dislike : dislikes) {
            adj.get(dislike[0]).add(dislike[1]);
            adj.get(dislike[1]).add(dislike[0]);
        }

        for (int i = 1; i <= n; i++) {
            if (colors[i] == 0) {
                if (!dfs(i, 1, colors, adj)) {
                    return false;
                }
            }
        }
        return true;
    }

    private boolean dfs(int node, int color, int[] colors, List<List<Integer>> adj) {
        colors[node] = color;
        for (int neighbor : adj.get(node)) {
            if (colors[neighbor] == 0) {
                if (!dfs(neighbor, -color, colors, adj)) {
                    return false;
                }
            } else if (colors[neighbor] == color) {
                return false;
            }
        }
        return true;
    }
}