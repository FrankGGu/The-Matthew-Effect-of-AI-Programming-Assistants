public class Solution {
    public int countPairs(int n, int[][] edges, int[] queries) {
        int[] degree = new int[n];
        for (int[] edge : edges) {
            degree[edge[0]]++;
            degree[edge[1]]++;
        }
        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (degree[i] + degree[j] > queries[0]) {
                    count++;
                }
            }
        }
        return count;
    }
}