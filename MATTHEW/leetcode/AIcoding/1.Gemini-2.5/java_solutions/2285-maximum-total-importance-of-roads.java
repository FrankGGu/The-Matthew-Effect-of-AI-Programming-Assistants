import java.util.Arrays;

class Solution {
    public long maximumImportance(int n, int[][] roads) {
        int[] degrees = new int[n];

        for (int[] road : roads) {
            degrees[road[0]]++;
            degrees[road[1]]++;
        }

        Arrays.sort(degrees);

        long totalImportance = 0;
        for (int i = 0; i < n; i++) {
            totalImportance += (long)(i + 1) * degrees[i];
        }

        return totalImportance;
    }
}