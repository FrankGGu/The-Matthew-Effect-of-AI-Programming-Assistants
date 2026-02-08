class Solution {
    public long minimumCost(String source, String target, char[] original, char[] changed, int[] cost) {
        long[][] minConversionCost = new long[26][26];

        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < 26; j++) {
                if (i == j) {
                    minConversionCost[i][j] = 0;
                } else {
                    minConversionCost[i][j] = Long.MAX_VALUE / 2; // Use a large value to avoid overflow when adding
                }
            }
        }

        for (int i = 0; i < original.length; i++) {
            int from = original[i] - 'a';
            int to = changed[i] - 'a';
            minConversionCost[from][to] = Math.min(minConversionCost[from][to], (long) cost[i]);
        }

        // Floyd-Warshall algorithm
        for (int k = 0; k < 26; k++) { // Intermediate character
            for (int i = 0; i < 26; i++) { // Start character
                for (int j = 0; j < 26; j++) { // End character
                    if (minConversionCost[i][k] != Long.MAX_VALUE / 2 && minConversionCost[k][j] != Long.MAX_VALUE / 2) {
                        minConversionCost[i][j] = Math.min(minConversionCost[i][j], minConversionCost[i][k] + minConversionCost[k][j]);
                    }
                }
            }
        }

        long totalCost = 0;
        for (int i = 0; i < source.length(); i++) {
            char sourceChar = source.charAt(i);
            char targetChar = target.charAt(i);

            if (sourceChar != targetChar) {
                int from = sourceChar - 'a';
                int to = targetChar - 'a';

                if (minConversionCost[from][to] == Long.MAX_VALUE / 2) {
                    return -1; // Impossible to convert
                }
                totalCost += minConversionCost[from][to];
            }
        }

        return totalCost;
    }
}