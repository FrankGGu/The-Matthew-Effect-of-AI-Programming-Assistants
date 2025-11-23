class Solution {
    private int[] parent;

    public boolean[] friendRequests(int n, int[][] restrictions, int[][] requests) {
        parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        boolean[] res = new boolean[requests.length];
        for (int i = 0; i < requests.length; i++) {
            int u = requests[i][0];
            int v = requests[i][1];
            int rootU = find(u);
            int rootV = find(v);
            if (rootU == rootV) {
                res[i] = true;
                continue;
            }
            boolean valid = true;
            for (int[] restriction : restrictions) {
                int x = restriction[0];
                int y = restriction[1];
                int rootX = find(x);
                int rootY = find(y);
                if ((rootX == rootU && rootY == rootV) || (rootX == rootV && rootY == rootU)) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                parent[rootV] = rootU;
                res[i] = true;
            } else {
                res[i] = false;
            }
        }
        return res;
    }

    private int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }
}