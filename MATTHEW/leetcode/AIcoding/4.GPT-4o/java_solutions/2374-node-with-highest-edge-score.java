class Solution {
    public int edgeScore(int[] edges) {
        long[] scores = new long[edges.length];
        for (int i = 0; i < edges.length; i++) {
            scores[edges[i]] += i;
        }
        long maxScore = -1;
        int result = -1;
        for (int i = 0; i < scores.length; i++) {
            if (scores[i] > maxScore || (scores[i] == maxScore && i < result)) {
                maxScore = scores[i];
                result = i;
            }
        }
        return result;
    }
}