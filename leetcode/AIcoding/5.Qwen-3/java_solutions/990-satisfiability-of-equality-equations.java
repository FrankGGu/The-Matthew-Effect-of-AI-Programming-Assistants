public class Solution {
    public boolean equationsPossible(int[][] equations) {
        int[] parent = new int[26];

        for (int i = 0; i < 26; i++) {
            parent[i] = i;
        }

        for (int[] eq : equations) {
            if (eq[1] == '=') {
                int x = eq[0] - 'a';
                int y = eq[2] - 'a';
                union(x, y, parent);
            }
        }

        for (int[] eq : equations) {
            if (eq[1] == '!') {
                int x = eq[0] - 'a';
                int y = eq[2] - 'a';
                if (find(x, parent) == find(y, parent)) {
                    return false;
                }
            }
        }

        return true;
    }

    private void union(int x, int y, int[] parent) {
        int rootX = find(x, parent);
        int rootY = find(y, parent);
        if (rootX != rootY) {
            parent[rootX] = rootY;
        }
    }

    private int find(int x, int[] parent) {
        while (parent[x] != x) {
            parent[x] = parent[parent[x]];
            x = parent[x];
        }
        return x;
    }
}