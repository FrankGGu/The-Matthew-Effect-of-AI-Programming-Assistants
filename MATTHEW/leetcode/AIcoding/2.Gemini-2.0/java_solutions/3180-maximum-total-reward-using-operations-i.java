import java.util.Arrays;

class Solution {
    public long maximumTotalReward(int[] reward, int[][] ops) {
        int n = reward.length;
        long totalReward = 0;
        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        Arrays.sort(ops, (a, b) -> Integer.compare(b[2], a[2]));

        for (int[] op : ops) {
            int u = op[0];
            int v = op[1];
            int w = op[2];

            int rootU = find(parent, u);
            int rootV = find(parent, v);

            if (rootU != rootV) {
                parent[rootU] = rootV;
                totalReward += w;
            }
        }

        for (int r : reward) {
            totalReward += r;
        }

        return totalReward;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }
}