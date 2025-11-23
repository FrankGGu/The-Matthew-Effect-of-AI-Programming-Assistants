public class Solution {
    public int findLatestGroup(int[] arr, int m) {
        int n = arr.length;
        int[] parent = new int[n + 1];
        int[] size = new int[n + 1];
        for (int i = 0; i <= n; i++) {
            parent[i] = i;
            size[i] = 1;
        }

        int result = -1;
        for (int i = 0; i < n; i++) {
            int index = arr[i];
            int root = find(index, parent);
            if (root != index) {
                size[root] += size[index];
                parent[index] = root;
            }
            if (size[root] == m) {
                result = i + 1;
            }
        }
        return result;
    }

    private int find(int x, int[] parent) {
        while (parent[x] != x) {
            parent[x] = parent[parent[x]];
            x = parent[x];
        }
        return x;
    }
}