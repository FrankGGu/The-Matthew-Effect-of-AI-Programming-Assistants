class Solution {
    private int[] parent;
    private int[] size;

    private int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    private void union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX == rootY) return;
        if (size[rootX] < size[rootY]) {
            parent[rootX] = rootY;
            size[rootY] += size[rootX];
        } else {
            parent[rootY] = rootX;
            size[rootX] += size[rootY];
        }
    }

    public int countComponents(int n, int[] nums) {
        parent = new int[n + 1];
        size = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            parent[i] = i;
            size[i] = 1;
        }

        boolean[] exists = new boolean[n + 1];
        for (int num : nums) {
            exists[num] = true;
        }

        for (int i = 1; i <= n; i++) {
            if (!exists[i]) continue;
            for (int j = 2 * i; j <= n; j += i) {
                if (exists[j]) {
                    union(i, j);
                }
            }
        }

        Set<Integer> roots = new HashSet<>();
        for (int i = 1; i <= n; i++) {
            if (exists[i]) {
                roots.add(find(i));
            }
        }
        return roots.size();
    }
}