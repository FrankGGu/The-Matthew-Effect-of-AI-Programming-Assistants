class Solution {
    class DSU {
        int[] parent;

        DSU(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }

        int find(int i) {
            if (parent[i] == i) {
                return i;
            }
            return parent[i] = find(parent[i]);
        }

        void union(int i, int j) {
            int rootI = find(i);
            int rootJ = find(j);
            if (rootI != rootJ) {
                parent[rootI] = rootJ;
            }
        }
    }

    public boolean equationsPossible(String[] equations) {
        DSU dsu = new DSU(26);

        for (String eq : equations) {
            if (eq.charAt(1) == '=') {
                int char1 = eq.charAt(0) - 'a';
                int char2 = eq.charAt(3) - 'a';
                dsu.union(char1, char2);
            }
        }

        for (String eq : equations) {
            if (eq.charAt(1) == '!') {
                int char1 = eq.charAt(0) - 'a';
                int char2 = eq.charAt(3) - 'a';
                if (dsu.find(char1) == dsu.find(char2)) {
                    return false;
                }
            }
        }

        return true;
    }
}