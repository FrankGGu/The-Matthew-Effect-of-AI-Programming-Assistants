class Solution {
    public int removeStones(int[][] stones) {
        int n = stones.length;
        UnionFind uf = new UnionFind(20000);
        for (int[] stone : stones) {
            uf.union(stone[0], stone[1] + 10000);
        }
        Set<Integer> seen = new HashSet<>();
        for (int[] stone : stones) {
            seen.add(uf.find(stone[0]));
        }
        return n - seen.size();
    }
}

class UnionFind {
    private int[] parent;

    public UnionFind(int size) {
        parent = new int[size];
        for (int i = 0; i < size; i++) {
            parent[i] = i;
        }
    }

    public int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    public void union(int x, int y) {
        parent[find(x)] = find(y);
    }
}