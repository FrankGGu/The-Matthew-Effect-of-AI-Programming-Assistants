import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    private Map<String, List<Character>> rulesMap;
    private Map<String, Boolean> memo;

    public boolean pyramidTransition(String bottom, List<String> allowed) {
        rulesMap = new HashMap<>();
        memo = new HashMap<>();

        for (String s : allowed) {
            String key = s.substring(0, 2);
            char value = s.charAt(2);
            rulesMap.computeIfAbsent(key, k -> new ArrayList<>()).add(value);
        }

        return dfs(bottom, 0, new StringBuilder());
    }

    private boolean dfs(String currentLayer, int currentLayerIndex, StringBuilder nextLayerSb) {
        // Base case 1: We have successfully formed a complete next layer.
        // Now, we need to try and build the pyramid from this newly formed `nextLayerSb`.
        if (currentLayerIndex == currentLayer.length() - 1) {
            String nextLayer = nextLayerSb.toString();

            // If the next layer has only one character, we've successfully built the entire pyramid.
            if (nextLayer.length() == 1) {
                return true;
            }

            // Check memoization for the newly formed `nextLayer` to avoid redundant computations.
            if (memo.containsKey(nextLayer)) {
                return memo.get(nextLayer);
            }

            // If not memoized, try to build the pyramid from this `nextLayer`.
            // Reset currentLayerIndex to 0 and create a new StringBuilder for the layer above `nextLayer`.
            boolean res = dfs(nextLayer, 0, new StringBuilder());
            memo.put(nextLayer, res); // Store the result for future reference.
            return res;
        }

        // Recursive step: Try to form the next character in `nextLayerSb`.
        String pair = currentLayer.substring(currentLayerIndex, currentLayerIndex + 2);

        // If there are no rules to form a character from this pair, this path is invalid.
        if (!rulesMap.containsKey(pair)) {
            return false;
        }

        List<Character> possibleChars = rulesMap.get(pair);
        for (char c : possibleChars) {
            nextLayerSb.append(c); // Add the character to the next layer.

            // Recursively try to form the next character in `nextLayerSb`
            // by moving to the next pair in `currentLayer`.
            if (dfs(currentLayer, currentLayerIndex + 1, nextLayerSb)) {
                return true; // Found a valid path, no need to explore other options.
            }

            nextLayerSb.deleteCharAt(nextLayerSb.length() - 1); // Backtrack: remove the last character.
        }

        // No character could be formed for this pair that leads to a solution.
        return false;
    }
}