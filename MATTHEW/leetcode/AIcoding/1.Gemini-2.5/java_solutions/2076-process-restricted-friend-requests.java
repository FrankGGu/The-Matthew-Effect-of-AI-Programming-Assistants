class DSU {
    int[] parent;
    int[] rank;

    public DSU(int n) {
        parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
        rank = new int[n];
    }

    public int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    public void union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);

        if (rootI != rootJ) {
            if (rank[rootI] < rank[rootJ]) {
                parent[rootI] = rootJ;
            } else if (rank[rootI] > rank[rootJ]) {
                parent[rootJ] = rootI;
            } else {
                parent[rootJ] = rootI;
                rank[rootI]++;
            }
        }
    }
}

class Solution {
    public boolean[] friendRequests(int n, int[][] restrictions, int[][] requests) {
        DSU dsu = new DSU(n);
        boolean[] ans = new boolean[requests.length];

        for (int i = 0; i < requests.length; i++) {
            int u = requests[i][0];
            int v = requests[i][1];

            int rootU = dsu.find(u);
            int rootV = dsu.find(v);

            if (rootU == rootV) {
                ans[i] = true;
                continue;
            }

            boolean canBeFriends = true;
            for (int[] restriction : restrictions) {
                int x = restriction[0];
                int y = restriction[1];

                int rootX = dsu.find(x);
                int rootY = dsu.find(y);

                if ((rootX == rootU && rootY == rootV) || (rootX == rootV && rootY == rootU)) {
                    canBeFriends = false;
                    break;
                }
            }

            if (canBeFriends) {
                dsu.union(rootU, rootV);
                ans[i] = true;
            } else {
                ans[i] = false;
            }
        }

        return ans;
    }
}