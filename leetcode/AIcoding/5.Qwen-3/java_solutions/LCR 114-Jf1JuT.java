public class Solution {
    public int alienOrder(String[] words) {
        if (words == null || words.length == 0) {
            return 0;
        }
        java.util.Map<Character, java.util.Set<Character>> graph = new java.util.HashMap<>();
        java.util.Map<Character, Integer> inDegree = new java.util.HashMap<>();
        for (String word : words) {
            for (char c : word.toCharArray()) {
                if (!graph.containsKey(c)) {
                    graph.put(c, new java.util.HashSet<>());
                    inDegree.put(c, 0);
                }
            }
        }
        for (int i = 0; i < words.length - 1; i++) {
            String word1 = words[i];
            String word2 = words[i + 1];
            int minLen = Math.min(word1.length(), word2.length());
            boolean found = false;
            for (int j = 0; j < minLen; j++) {
                char c1 = word1.charAt(j);
                char c2 = word2.charAt(j);
                if (c1 != c2) {
                    if (!graph.get(c1).contains(c2)) {
                        graph.get(c1).add(c2);
                        inDegree.put(c2, inDegree.get(c2) + 1);
                    }
                    found = true;
                    break;
                }
            }
            if (!found && word1.length() > word2.length()) {
                return -1;
            }
        }
        java.util.Queue<Character> queue = new java.util.LinkedList<>();
        for (char c : inDegree.keySet()) {
            if (inDegree.get(c) == 0) {
                queue.add(c);
            }
        }
        StringBuilder result = new StringBuilder();
        while (!queue.isEmpty()) {
            char c = queue.poll();
            result.append(c);
            for (char neighbor : graph.get(c)) {
                inDegree.put(neighbor, inDegree.get(neighbor) - 1);
                if (inDegree.get(neighbor) == 0) {
                    queue.add(neighbor);
                }
            }
        }
        if (result.length() != inDegree.size()) {
            return -1;
        }
        return result.length();
    }
}