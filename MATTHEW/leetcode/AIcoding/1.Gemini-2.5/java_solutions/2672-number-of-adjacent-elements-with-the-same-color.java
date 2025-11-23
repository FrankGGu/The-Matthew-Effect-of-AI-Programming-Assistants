class Solution {
    public int[] colorTheArray(int n, int[][] queries) {
        int[] colors = new int[n]; // All elements are initially 0
        int currentAdjacentPairs = 0;
        int[] result = new int[queries.length];

        // Initial adjacent pairs (all 0s)
        // If n > 1, there are n-1 pairs of (0,0)
        // If n <= 1, there are 0 pairs
        // The problem statement implies colors are 0 initially, and 0 is a valid color.
        // So, if n > 1, currentAdjacentPairs would be n-1.
        // However, the problem usually implies that "0" is an uncolored state, and we only count pairs of non-zero colors.
        // Let's assume 0 is a valid color and count (0,0) pairs.
        // If n=1, currentAdjacentPairs = 0.
        // If n=0, currentAdjacentPairs = 0.
        // The example trace suggests that (0,0) pairs are counted.
        // For [0,0,0,0], count is 3.
        // So, currentAdjacentPairs should be initialized to n - 1 if n > 0, otherwise 0.
        // But the problem description is missing, so I'll stick to the common interpretation
        // where initial 0s don't count towards "same color" pairs until they are colored with a non-zero color.
        // If 0s count, then `currentAdjacentPairs = (n > 0 ? n - 1 : 0);`
        // Given typical LeetCode problem interpretations for "color" problems, 0 is often a 'blank' state.
        // Let's re-evaluate based on the example trace I did in thought process.
        // My trace: `n = 4`, `colors = [0,0,0,0]`, `count = 3`. This means (0,0) pairs *are* counted.
        // So `currentAdjacentPairs` should be initialized to `n-1` for `n > 0`.

        // Let's refine the initial state:
        // The problem description is missing. Assuming the typical LeetCode problem "Number of Adjacent Elements With the Same Color"
        // where `colors` array is initialized to all zeros, and 0 is a valid color.
        // So, if `n > 1`, there are `n-1` pairs of `(0,0)`.
        if (n > 1) {
            currentAdjacentPairs = n - 1;
        } else {
            currentAdjacentPairs = 0;
        }

        for (int i = 0; i < queries.length; i++) {
            int index = queries[i][0];
            int newColor = queries[i][1];

            int oldColor = colors[index];

            if (oldColor == newColor) {
                // If the color is not changing, the number of adjacent pairs remains the same.
                result[i] = currentAdjacentPairs;
                continue;
            }

            // Calculate change in adjacent pairs
            int delta = 0;

            // Check left neighbor
            if (index > 0) {
                // If left neighbor had the oldColor, the pair (left, oldColor) is broken.
                if (colors[index - 1] == oldColor) {
                    delta--;
                }
                // If left neighbor now matches newColor, the pair (left, newColor) is formed.
                if (colors[index - 1] == newColor) {
                    delta++;
                }
            }

            // Check right neighbor
            if (index < n - 1) {
                // If right neighbor had the oldColor, the pair (oldColor, right) is broken.
                if (colors[index + 1] == oldColor) {
                    delta--;
                }
                // If right neighbor now matches newColor, the pair (newColor, right) is formed.
                if (colors[index + 1] == newColor) {
                    delta++;
                }
            }

            // Update the color of the element
            colors[index] = newColor;

            // Update the total count of adjacent pairs
            currentAdjacentPairs += delta;

            // Store the current count in the result array
            result[i] = currentAdjacentPairs;
        }

        return result;
    }
}