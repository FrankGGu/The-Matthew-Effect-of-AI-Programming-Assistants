class Solution {
    public int[] queryResults(int limit, int[][] queries) {
        Map<Integer, Integer> ballToColor = new HashMap<>();
        Map<Integer, Integer> colorCount = new HashMap<>();
        int[] result = new int[queries.length];
        int distinctColors = 0;

        for (int i = 0; i < queries.length; i++) {
            int ball = queries[i][0];
            int newColor = queries[i][1];

            if (ballToColor.containsKey(ball)) {
                int oldColor = ballToColor.get(ball);
                colorCount.put(oldColor, colorCount.get(oldColor) - 1);
                if (colorCount.get(oldColor) == 0) {
                    distinctColors--;
                    colorCount.remove(oldColor);
                }
            }

            ballToColor.put(ball, newColor);
            colorCount.put(newColor, colorCount.getOrDefault(newColor, 0) + 1);
            if (colorCount.get(newColor) == 1) {
                distinctColors++;
            }

            result[i] = distinctColors;
        }

        return result;
    }
}