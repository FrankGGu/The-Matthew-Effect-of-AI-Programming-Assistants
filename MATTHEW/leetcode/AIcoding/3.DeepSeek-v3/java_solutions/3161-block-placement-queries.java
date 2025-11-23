class Solution {
    private int[] parent;
    private int[] size;

    public boolean[] blockPlacementQueries(int n, int[][] queries, int[][] blocks) {
        parent = new int[n];
        size = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            size[i] = 1;
        }

        boolean[] blocked = new boolean[n];
        boolean[] result = new boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int[] query = queries[i];
            int[] block = blocks[i];
            if (query[0] == 1) {
                int pos = block[0];
                if (!blocked[pos]) {
                    blocked[pos] = true;
                    if (pos > 0 && blocked[pos - 1]) {
                        union(pos, pos - 1);
                    }
                    if (pos < n - 1 && blocked[pos + 1]) {
                        union(pos, pos + 1);
                    }
                }
            } else {
                int start = query[1];
                int end = query[2];
                if (blocked[start] || blocked[end]) {
                    result[i] = false;
                } else {
                    result[i] = find(start) != find(end);
                }
            }
        }
        return result;
    }

    private int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    private void union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (size[rootX] < size[rootY]) {
                parent[rootX] = rootY;
                size[rootY] += size[rootX];
            } else {
                parent[rootY] = rootX;
                size[rootX] += size[rootY];
            }
        }
    }
}