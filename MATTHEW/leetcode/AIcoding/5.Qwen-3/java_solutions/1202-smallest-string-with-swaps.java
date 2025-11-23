public class Solution {

import java.util.*;

public class Solution {
    public String smallestStringWithSwaps(String s) {
        UnionFind uf = new UnionFind(s.length());
        for (int i = 0; i < s.length() - 1; i++) {
            uf.union(i, i + 1);
        }

        Map<Integer, List<Character>> groups = new HashMap<>();
        for (int i = 0; i < s.length(); i++) {
            int root = uf.find(i);
            groups.putIfAbsent(root, new ArrayList<>());
            groups.get(root).add(s.charAt(i));
        }

        for (List<Character> group : groups.values()) {
            Collections.sort(group);
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            int root = uf.find(i);
            sb.append(groups.get(root).remove(0));
        }

        return sb.toString();
    }

    private static class UnionFind {
        private int[] parent;

        public UnionFind(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
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
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootX] = rootY;
            }
        }
    }
}
}