class Solution {
    public long maximumImportance(int n, int[][] roads) {
        long[] importance = new long[n];
        for (int[] road : roads) {
            importance[road[0]]++;
            importance[road[1]]++;
        }
        Arrays.sort(importance);
        long totalImportance = 0;
        for (int i = 0; i < n; i++) {
            totalImportance += importance[i] * (i + 1);
        }
        return totalImportance;
    }
}