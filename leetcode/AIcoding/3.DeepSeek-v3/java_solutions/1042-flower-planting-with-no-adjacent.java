class Solution {
    public int[] gardenNoAdj(int n, int[][] paths) {
        Map<Integer, Set<Integer>> graph = new HashMap<>();
        for (int i = 1; i <= n; i++) {
            graph.put(i, new HashSet<>());
        }
        for (int[] path : paths) {
            int x = path[0];
            int y = path[1];
            graph.get(x).add(y);
            graph.get(y).add(x);
        }
        int[] res = new int[n];
        for (int i = 1; i <= n; i++) {
            boolean[] used = new boolean[5];
            for (int neighbor : graph.get(i)) {
                used[res[neighbor - 1]] = true;
            }
            for (int color = 1; color <= 4; color++) {
                if (!used[color]) {
                    res[i - 1] = color;
                    break;
                }
            }
        }
        return res;
    }
}