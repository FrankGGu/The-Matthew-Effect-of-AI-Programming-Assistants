public class Solution {
    public String lexicographicallySmallestEquivalentString(String A, String B, String S) {
        int[] parent = new int[26];
        for (int i = 0; i < 26; i++) {
            parent[i] = i;
        }

        for (int i = 0; i < A.length(); i++) {
            int x = A.charAt(i) - 'a';
            int y = B.charAt(i) - 'a';
            union(parent, x, y);
        }

        char[] result = new char[S.length()];
        for (int i = 0; i < S.length(); i++) {
            int root = find(parent, S.charAt(i) - 'a');
            result[i] = (char) ('a' + root);
        }

        return new String(result);
    }

    private int find(int[] parent, int x) {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }

    private void union(int[] parent, int x, int y) {
        int rootX = find(parent, x);
        int rootY = find(parent, y);
        if (rootX != rootY) {
            parent[Math.max(rootX, rootY)] = Math.min(rootX, rootY);
        }
    }
}