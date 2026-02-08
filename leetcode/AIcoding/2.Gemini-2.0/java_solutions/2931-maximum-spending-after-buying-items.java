import java.util.Arrays;

class Solution {
    public long maxSpending(int[][] costs) {
        int m = costs.length;
        int n = costs[0].length;
        long ans = 0;
        Integer[] indices = new Integer[m];
        for (int i = 0; i < m; i++) {
            indices[i] = i;
        }

        Arrays.sort(indices, (a, b) -> costs[a][n - 1] - costs[b][n - 1]);

        int[] current = new int[m];
        Arrays.fill(current, n - 1);

        for (int day = 1; day <= m * n; day++) {
            int bestIndex = -1;
            int maxCost = -1;

            for (int i = 0; i < m; i++) {
                int index = indices[i];
                if (current[index] >= 0 && costs[index][current[index]] > maxCost) {
                    maxCost = costs[index][current[index]];
                    bestIndex = index;
                }
            }

            ans += (long)maxCost * day;
            current[bestIndex]--;
        }

        return ans;
    }
}