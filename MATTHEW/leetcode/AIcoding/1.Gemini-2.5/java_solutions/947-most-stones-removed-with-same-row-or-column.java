import java.util.HashMap;
import java.util.Map;

class Solution {
    class DSU {
        int[] parent;
        int count;

        public DSU(int n) {
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
    }

    public int removeStones(int[][] stones) {
        int n = stones.length;
        DSU dsu = new DSU(n);

        Map<Integer, Integer> rowToFirstStoneIndex = new HashMap<>();
        Map<Integer, Integer> colToFirstStoneIndex = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int r = stones[i][0];
            int c = stones[i][1];

            if (rowToFirstStoneIndex.containsKey(r)) {
                dsu.union(i, rowToFirstStoneIndex.get(r));
            } else {
                rowToFirstStoneIndex.put(r, i);
            }

            if (colToFirstStoneIndex.containsKey(c)) {
                dsu.union(i, colToFirstStoneIndex.get(c));
            } else {
                colToFirstStoneIndex.put(c, i);
            }
        }

        return n - dsu.count;
    }
}