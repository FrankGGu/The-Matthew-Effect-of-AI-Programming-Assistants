import java.util.*;

public class Solution {
    public List<List<String>> findLadders(String beginWord, String endWord, List<String> wordList) {
        Set<String> wordSet = new HashSet<>(wordList);
        List<List<String>> res = new ArrayList<>();
        Map<String, List<String>> graph = new HashMap<>();
        if (!wordSet.contains(endWord)) return res;

        // BFS to build the graph
        Queue<String> queue = new LinkedList<>();
        queue.add(beginWord);
        Set<String> visited = new HashSet<>();
        visited.add(beginWord);
        boolean found = false;

        while (!queue.isEmpty() && !found) {
            int size = queue.size();
            Set<String> localVisited = new HashSet<>();
            for (int i = 0; i < size; i++) {
                String word = queue.poll();
                char[] chars = word.toCharArray();
                for (int j = 0; j < chars.length; j++) {
                    char originalChar = chars[j];
                    for (char c = 'a'; c <= 'z'; c++) {
                        if (c == originalChar) continue;
                        chars[j] = c;
                        String newWord = new String(chars);
                        if (wordSet.contains(newWord)) {
                            if (!visited.contains(newWord)) {
                                localVisited.add(newWord);
                                queue.add(newWord);
                            }
                            graph.computeIfAbsent(word, k -> new ArrayList<>()).add(newWord);
                        }
                    }
                    chars[j] = originalChar;
                }
            }
            visited.addAll(localVisited);
            if (!localVisited.isEmpty() && visited.contains(endWord)) found = true;
        }

        // DFS to find all paths
        List<String> path = new ArrayList<>();
        path.add(beginWord);
        dfs(beginWord, endWord, graph, path, res);
        return res;
    }

    private void dfs(String current, String endWord, Map<String, List<String>> graph, List<String> path, List<List<String>> res) {
        if (current.equals(endWord)) {
            res.add(new ArrayList<>(path));
            return;
        }
        if (!graph.containsKey(current)) return;
        for (String neighbor : graph.get(current)) {
            path.add(neighbor);
            dfs(neighbor, endWord, graph, path, res);
            path.remove(path.size() - 1);
        }
    }
}