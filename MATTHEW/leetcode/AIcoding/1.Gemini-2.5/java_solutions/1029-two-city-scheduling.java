import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int twoCitySchedCost(int[][] costs) {
        Arrays.sort(costs, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                return (a[0] - a[1]) - (b[0] - b[1]);
            }
        });

        int totalCost = 0;
        int n = costs.length / 2;

        for (int i = 0; i < n; i++) {
            totalCost += costs[i][0];
        }

        for (int i = n; i < costs.length; i++) {
            totalCost += costs[i][1];
        }

        return totalCost;
    }
}