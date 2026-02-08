public class Solution {

import java.util.*;

public class Solution {
    public int removeStones(int[][] stones) {
        Map<Integer, Integer> rowMap = new HashMap<>();
        Map<Integer, Integer> colMap = new HashMap<>();
        UnionFind uf = new UnionFind();

        for (int[] stone : stones) {
            int row = stone[0];
            int col = stone[1];
            if (!rowMap.containsKey(row)) {
                rowMap.put(row, uf.add());
            }
            if (!colMap.containsKey(col)) {
                colMap.put(col, uf.add());
            }
            uf.union(rowMap.get(row), colMap.get(col));
        }

        Set<Integer> roots = new HashSet<>();
        for (int[] stone : stones) {
            int row = stone[0];
            int col = stone[1];
            roots.add(uf.find(rowMap.get(row)));
        }

        return stones.length - roots.size();
    }

    static class UnionFind {
        private Map<Integer, Integer> parent = new HashMap<>();
        private int count = 0;

        public int add() {
            parent.put(count, count);
            return count++;
        }

        public int find(int x) {
            if (parent.get(x) != x) {
                parent.put(x, find(parent.get(x)));
            }
            return parent.get(x);
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent.put(rootY, rootX);
            }
        }
    }
}
}