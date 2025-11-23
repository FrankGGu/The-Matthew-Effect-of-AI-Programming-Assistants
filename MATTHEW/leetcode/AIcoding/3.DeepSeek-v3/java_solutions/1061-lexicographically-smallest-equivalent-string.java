class Solution {
    private int[] parent;

    public String smallestEquivalentString(String s1, String s2, String baseStr) {
        parent = new int[26];
        for (int i = 0; i < 26; i++) {
            parent[i] = i;
        }

        for (int i = 0; i < s1.length(); i++) {
            int u = s1.charAt(i) - 'a';
            int v = s2.charAt(i) - 'a';
            union(u, v);
        }

        StringBuilder sb = new StringBuilder();
        for (char c : baseStr.toCharArray()) {
            int p = find(c - 'a');
            sb.append((char) (p + 'a'));
        }
        return sb.toString();
    }

    private int find(int u) {
        while (parent[u] != u) {
            parent[u] = parent[parent[u]];
            u = parent[u];
        }
        return u;
    }

    private void union(int u, int v) {
        int pu = find(u);
        int pv = find(v);
        if (pu < pv) {
            parent[pv] = pu;
        } else {
            parent[pu] = pv;
        }
    }
}