import java.util.Arrays;

class Solution {
    public boolean[] friendRequests(int n, int[][] restrictions, int[][] requests) {
        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        boolean[] result = new boolean[requests.length];
        Arrays.fill(result, false);

        for (int i = 0; i < requests.length; i++) {
            int u = requests[i][0];
            int v = requests[i][1];

            int rootU = find(parent, u);
            int rootV = find(parent, v);

            if (rootU == rootV) {
                result[i] = true;
                continue;
            }

            boolean safe = true;
            for (int[] restriction : restrictions) {
                int a = restriction[0];
                int b = restriction[1];

                int rootA = find(parent, a);
                int rootB = find(parent, b);

                if ((rootU == rootA && rootV == rootB) || (rootU == rootB && rootV == rootA)) {
                    safe = false;
                    break;
                }
            }

            if (safe) {
                parent[rootU] = rootV;
                result[i] = true;
            }
        }

        return result;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }
}