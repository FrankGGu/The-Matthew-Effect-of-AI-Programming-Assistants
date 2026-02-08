class Solution {
    public int edgeScore(int[] edges) {
        int n = edges.length;
        long[] scores = new long[n];
        for (int i = 0; i < n; i++) {
            scores[edges[i]] += i;
        }
        long maxScore = -1;
        int result = -1;
        for (int i = 0; i < n; i++) {
            if (scores[i] > maxScore) {
                maxScore = scores[i];
                result = i;
            } else if (scores[i] == maxScore && i < result) {
                result = i;
            }
        }
        return result;
    }
}