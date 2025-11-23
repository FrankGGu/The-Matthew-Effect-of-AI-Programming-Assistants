class Solution {
    public boolean equationsPossible(String[] equations) {
        int[] parent = new int[26];
        for (int i = 0; i < 26; i++) {
            parent[i] = i;
        }

        for (String equation : equations) {
            if (equation.charAt(1) == '=') {
                int a = equation.charAt(0) - 'a';
                int b = equation.charAt(3) - 'a';
                int rootA = find(parent, a);
                int rootB = find(parent, b);
                if (rootA != rootB) {
                    parent[rootA] = rootB;
                }
            }
        }

        for (String equation : equations) {
            if (equation.charAt(1) == '!') {
                int a = equation.charAt(0) - 'a';
                int b = equation.charAt(3) - 'a';
                int rootA = find(parent, a);
                int rootB = find(parent, b);
                if (rootA == rootB) {
                    return false;
                }
            }
        }

        return true;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }
}