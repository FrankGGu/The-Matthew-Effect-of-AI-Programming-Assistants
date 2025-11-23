class Solution {
    private int[] xor;
    private int[] nums;
    private int totalXor;
    private int n;
    private List<Integer>[] tree;
    private int res;

    public int minimumScore(int[] nums, int[][] edges) {
        this.n = nums.length;
        this.nums = nums;
        this.tree = new List[n];
        for (int i = 0; i < n; i++) {
            tree[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            tree[u].add(v);
            tree[v].add(u);
        }

        this.xor = new int[n];
        this.totalXor = 0;
        for (int num : nums) {
            totalXor ^= num;
        }

        this.res = Integer.MAX_VALUE;
        for (int i = 0; i < edges.length; i++) {
            for (int j = i + 1; j < edges.length; j++) {
                int[] edge1 = edges[i];
                int[] edge2 = edges[j];
                int u1 = edge1[0], v1 = edge1[1];
                int u2 = edge2[0], v2 = edge2[1];
                boolean[] cut1 = new boolean[n];
                boolean[] cut2 = new boolean[n];
                cutEdge(u1, v1, cut1);
                cutEdge(u2, v2, cut2);
                int[] roots = findRoots(cut1, cut2);
                if (roots.length < 3) continue;
                int x1 = computeXor(roots[0], cut1, cut2);
                int x2 = computeXor(roots[1], cut1, cut2);
                int x3 = totalXor ^ x1 ^ x2;
                int max = Math.max(x1, Math.max(x2, x3));
                int min = Math.min(x1, Math.min(x2, x3));
                res = Math.min(res, max - min);
            }
        }
        return res;
    }

    private void cutEdge(int u, int v, boolean[] cut) {
        Arrays.fill(cut, false);
        Queue<Integer> q = new LinkedList<>();
        q.offer(u);
        cut[u] = true;
        while (!q.isEmpty()) {
            int node = q.poll();
            for (int neighbor : tree[node]) {
                if (neighbor != v && !cut[neighbor]) {
                    cut[neighbor] = true;
                    q.offer(neighbor);
                }
            }
        }
    }

    private int[] findRoots(boolean[] cut1, boolean[] cut2) {
        int[] roots = new int[3];
        int idx = 0;
        boolean[] visited = new boolean[n];
        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                roots[idx++] = i;
                Queue<Integer> q = new LinkedList<>();
                q.offer(i);
                visited[i] = true;
                while (!q.isEmpty()) {
                    int node = q.poll();
                    for (int neighbor : tree[node]) {
                        if (!visited[neighbor] && !isCut(node, neighbor, cut1, cut2)) {
                            visited[neighbor] = true;
                            q.offer(neighbor);
                        }
                    }
                }
            }
            if (idx == 3) break;
        }
        return roots;
    }

    private boolean isCut(int u, int v, boolean[] cut1, boolean[] cut2) {
        return (cut1[u] && !cut1[v]) || (!cut1[u] && cut1[v]) ||
               (cut2[u] && !cut2[v]) || (!cut2[u] && cut2[v]);
    }

    private int computeXor(int root, boolean[] cut1, boolean[] cut2) {
        int xorSum = 0;
        Queue<Integer> q = new LinkedList<>();
        boolean[] visited = new boolean[n];
        q.offer(root);
        visited[root] = true;
        while (!q.isEmpty()) {
            int node = q.poll();
            xorSum ^= nums[node];
            for (int neighbor : tree[node]) {
                if (!visited[neighbor] && !isCut(node, neighbor, cut1, cut2)) {
                    visited[neighbor] = true;
                    q.offer(neighbor);
                }
            }
        }
        return xorSum;
    }
}