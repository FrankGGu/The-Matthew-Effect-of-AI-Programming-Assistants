class Solution {
    public int colorTheArray(int n, int[][] queries) {
        int[] colors = new int[n];
        int adjacentCount = 0;
        int[] result = new int[queries.length];

        for (int i = 0; i < queries.length; i++) {
            int index = queries[i][0];
            int color = queries[i][1];
            if (colors[index] != 0) {
                if (index > 0 && colors[index] == colors[index - 1]) adjacentCount--;
                if (index < n - 1 && colors[index] == colors[index + 1]) adjacentCount--;
            }
            colors[index] = color;
            if (index > 0 && colors[index] == colors[index - 1]) adjacentCount++;
            if (index < n - 1 && colors[index] == colors[index + 1]) adjacentCount++;
            result[i] = adjacentCount;
        }

        return result;
    }
}