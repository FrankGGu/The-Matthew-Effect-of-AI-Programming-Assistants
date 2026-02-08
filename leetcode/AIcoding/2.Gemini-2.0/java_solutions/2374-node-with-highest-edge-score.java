class Solution {
    public int edgeScore(int[] edges) {
        int n = edges.length;
        long[] scores = new long[n];
        for (int i = 0; i < n; i++) {
            scores[edges[i]] += i;
        }
        int maxNode = 0;
        long maxScore = scores[0];
        for (int i = 1; i < n; i++) {
            if (scores[i] > maxScore) {
                maxScore = scores[i];
                maxNode = i;
            }
        }
        return maxNode;
    }
}