import java.util.*;

class Solution {
    public String alienOrder(String[] words) {
        Map<Character, Set<Character>> adj = new HashMap<>();
        Map<Character, Integer> inDegree = new HashMap<>();

        // Initialize in-degrees for all unique characters found in words
        for (String word : words) {
            for (char c : word.toCharArray()) {
                inDegree.put(c, 0);
            }
        }

        // Build the graph and populate in-degrees
        for (int i = 0; i < words.length - 1; i++) {
            String word1 = words[i];
            String word2 = words[i + 1];

            // Check for invalid order, e.g., ["abc", "ab"]
            if (word1.length() > word2.length() && word1.startsWith(word2)) {
                return "";
            }

            // Find the first differing character to establish an order
            int len = Math.min(word1.length(), word2.length());
            for (int k = 0; k < len; k++) {
                char c1 = word1.charAt(k);
                char c2 = word2.charAt(k);
                if (c1 != c2) {
                    // Add edge c1 -> c2 if it doesn't already exist
                    Set<Character> neighbors = adj.computeIfAbsent(c1, key -> new HashSet<>());
                    if (neighbors.add(c2)) { // If c2 was newly added as a neighbor of c1
                        inDegree.put(c2, inDegree.get(c2) + 1);
                    }
                    break; // Only the first differing pair matters for an edge
                }
            }
        }

        // Perform topological sort using Kahn's algorithm (BFS)
        Queue<Character> queue = new LinkedList<>();
        for (char c : inDegree.keySet()) {
            if (inDegree.get(c) == 0) {
                queue.offer(c);
            }
        }

        StringBuilder result = new StringBuilder();
        while (!queue.isEmpty()) {
            char u = queue.poll();
            result.append(u);

            // Decrement in-degree of neighbors
            if (adj.containsKey(u)) {
                for (char v : adj.get(u)) {
                    inDegree.put(v, inDegree.get(v) - 1);
                    if (inDegree.get(v) == 0) {
                        queue.offer(v);
                    }
                }
            }
        }

        // If the length of the result string is not equal to the total number of unique characters,
        // it means there was a cycle in the graph, and no valid order exists.
        if (result.length() != inDegree.size()) {
            return "";
        }

        return result.toString();
    }
}