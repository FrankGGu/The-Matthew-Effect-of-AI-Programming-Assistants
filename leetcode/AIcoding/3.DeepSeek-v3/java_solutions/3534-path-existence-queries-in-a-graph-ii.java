class UnionFind {
    private int[] parent;
    private int[] rank;

    public UnionFind(int size) {
        parent = new int[size];
        rank = new int[size];
        for (int i = 0; i < size; i++) {
            parent[i] = i;
            rank[i] = 1;
        }
    }

    public int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    public void union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
        }
    }
}

class DistanceLimitedPathsExist {
    private UnionFind[] ufArray;

    public DistanceLimitedPathsExist(int n, int[][] edgeList) {
        Arrays.sort(edgeList, (a, b) -> a[2] - b[2]);
        ufArray = new UnionFind[edgeList.length + 1];
        ufArray[0] = new UnionFind(n);
        for (int i = 1; i <= edgeList.length; i++) {
            int[] edge = edgeList[i - 1];
            ufArray[i] = new UnionFind(n);
            for (int j = 0; j < n; j++) {
                ufArray[i].parent[j] = ufArray[i - 1].parent[j];
                ufArray[i].rank[j] = ufArray[i - 1].rank[j];
            }
            ufArray[i].union(edge[0], edge[1]);
        }
    }

    public boolean query(int p, int q, int limit) {
        int left = 0, right = ufArray.length - 1;
        while (left < right) {
            int mid = (left + right + 1) / 2;
            if (mid == 0 || (mid <= ufArray.length - 1 && ufArray[mid].find(p) == ufArray[mid].find(q))) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left > 0 && ufArray[left].find(p) == ufArray[left].find(q) && left < limit;
    }
}