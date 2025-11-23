class Solution {
    public double[] calcProbabilities(int n, int[][] edges) {
        double[] probabilities = new double[n];
        int[] degrees = new int[n];

        for (int[] edge : edges) {
            degrees[edge[0]]++;
            degrees[edge[1]]++;
        }

        for (int i = 0; i < n; i++) {
            probabilities[i] = 1.0 / (degrees[i] + 1);
        }

        return probabilities;
    }
}