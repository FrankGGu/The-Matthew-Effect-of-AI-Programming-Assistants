class Solution {
    public int numOfMessages(int n, int[][] messages) {
        int[] parents = new int[n];
        for (int i = 0; i < n; i++) {
            parents[i] = i;
        }

        for (int[] message : messages) {
            union(parents, message[0], message[1]);
        }

        int count = 0;
        for (int i = 0; i < n; i++) {
            if (find(parents, i) == i) {
                count++;
            }
        }

        return count;
    }

    private int find(int[] parents, int x) {
        if (parents[x] != x) {
            parents[x] = find(parents, parents[x]);
        }
        return parents[x];
    }

    private void union(int[] parents, int x, int y) {
        int rootX = find(parents, x);
        int rootY = find(parents, y);
        if (rootX != rootY) {
            parents[rootY] = rootX;
        }
    }
}