import java.util.ArrayList;
import java.util.List;

class Solution {
    public int numSimilarGroups(String[] strs) {
        int n = strs.length;
        UnionFind uf = new UnionFind(n);

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (isSimilar(strs[i], strs[j])) {
                    uf.union(i, j);
                }
            }
        }

        return uf.getCount();
    }

    private boolean isSimilar(String s1, String s2) {
        List<Integer> diffIndices = new ArrayList<>();
        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                diffIndices.add(i);
            }
        }

        if (diffIndices.isEmpty()) {
            return true;
        }
        if (diffIndices.size() == 2) {
            int i = diffIndices.get(0);
            int j = diffIndices.get(1);
            return s1.charAt(i) == s2.charAt(j) && s1.charAt(j) == s2.charAt(i);
        }
        return false;
    }

    class UnionFind {
        private int[] parent;
        private int count;

        public UnionFind(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
            count = n;
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
                parent[rootI] = rootJ;
                count--;
            }
        }

        public int getCount() {
            return count;
        }
    }
}