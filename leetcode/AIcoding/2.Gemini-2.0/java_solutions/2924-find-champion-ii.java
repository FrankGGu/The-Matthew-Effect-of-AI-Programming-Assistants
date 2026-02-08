class Solution {
    public int findChampion(int n, int[][] edges) {
        int[] indegree = new int[n];
        for (int[] edge : edges) {
            indegree[edge[1]]++;
        }

        int champion = -1;
        int count = 0;
        for (int i = 0; i < n; i++) {
            if (indegree[i] == 0) {
                champion = i;
                count++;
            }
        }

        if (count == 1) {
            return champion;
        } else {
            return -1;
        }
    }
}