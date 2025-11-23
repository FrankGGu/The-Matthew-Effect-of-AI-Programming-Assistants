import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[] queryResults(int n, int[] colors, int[][] queries) {
        // colorCounts stores the frequency of each color currently present among the balls.
        Map<Integer, Integer> colorCounts = new HashMap<>();
        // currentBallColors stores the color of the ball at each index.
        // It helps to find the old color when a ball's color is changed.
        int[] currentBallColors = new int[n];

        // Initialize currentBallColors and colorCounts based on the initial state of the balls.
        // The input 'colors' array represents the initial color of each ball.
        for (int i = 0; i < n; i++) {
            currentBallColors[i] = colors[i];
            colorCounts.put(colors[i], colorCounts.getOrDefault(colors[i], 0) + 1);
        }

        // distinctCount tracks the number of unique colors.
        int distinctCount = colorCounts.size();
        // answer will store the distinct count after each query.
        int[] answer = new int[queries.length];

        // Process each query
        for (int i = 0; i < queries.length; i++) {
            int index = queries[i][0];
            int newColor = queries[i][1];

            int oldColor = currentBallColors[index];

            // Only update if the color actually changes
            if (oldColor != newColor) {
                // Decrement count for the old color
                colorCounts.put(oldColor, colorCounts.get(oldColor) - 1);
                // If the count of oldColor becomes 0, it means this color is no longer present.
                if (colorCounts.get(oldColor) == 0) {
                    colorCounts.remove(oldColor); // Remove from map for efficiency
                    distinctCount--;
                }

                // Increment count for the new color
                // If newColor was not present before, increment distinctCount.
                if (!colorCounts.containsKey(newColor)) {
                    distinctCount++;
                }
                colorCounts.put(newColor, colorCounts.getOrDefault(newColor, 0) + 1);

                // Update the ball's color in currentBallColors
                currentBallColors[index] = newColor;
            }
            // If oldColor == newColor, no change in distinct colors or counts.

            // Store the current distinct count in the answer array
            answer[i] = distinctCount;
        }

        return answer;
    }
}