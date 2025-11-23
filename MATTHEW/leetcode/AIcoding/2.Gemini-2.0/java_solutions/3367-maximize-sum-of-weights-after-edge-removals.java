import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public long maxKSumOfWeights(int[] weights, int[][] edges, int k) {
        int n = weights.length;
        long[] degree = new long[n];
        for (int[] edge : edges) {
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }

        Arrays.sort(indices, Comparator.comparingLong(i -> degree[i]));

        long[] selected = new long[n];
        for (int i = 0; i < k; i++) {
            selected[indices[n - 1 - i]] = 1;
        }

        long sum = 0;
        for (int i = 0; i < n; i++) {
            if (selected[i] == 1) {
                sum += weights[i];
            }
        }

        return sum;
    }
}