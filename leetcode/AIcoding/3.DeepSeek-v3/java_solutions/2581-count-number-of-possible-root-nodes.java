class Solution {
    private List<List<Integer>> adj;
    private int[] parent;
    private int[] depth;
    private int[] count;
    private int k;
    private int res;

    public int rootCount(int[][] edges, int[][] guesses, int k) {
        this.k = k;
        int n = edges.length + 1;
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        parent = new int[n];
        depth = new int[n];
        count = new int[n];
        Arrays.fill(parent, -1);
        dfs(0, -1);

        Set<Long> guessSet = new HashSet<>();
        for (int[] guess : guesses) {
            int u = guess[0], v = guess[1];
            guessSet.add((long) u * n + v);
        }

        int correct = 0;
        for (int i = 1; i < n; i++) {
            if (guessSet.contains((long) parent[i] * n + i)) {
                correct++;
            }
        }

        res = 0;
        if (correct >= k) {
            res++;
        }
        reroot(0, -1, correct, guessSet, n);
        return res;
    }

    private void dfs(int u, int p) {
        parent[u] = p;
        for (int v : adj.get(u)) {
            if (v != p) {
                depth[v] = depth[u] + 1;
                dfs(v, u);
            }
        }
    }

    private void reroot(int u, int p, int correct, Set<Long> guessSet, int n) {
        for (int v : adj.get(u)) {
            if (v != p) {
                int newCorrect = correct;
                if (guessSet.contains((long) u * n + v)) {
                    newCorrect--;
                }
                if (guessSet.contains((long) v * n + u)) {
                    newCorrect++;
                }
                if (newCorrect >= k) {
                    res++;
                }
                reroot(v, u, newCorrect, guessSet, n);
            }
        }
    }
}