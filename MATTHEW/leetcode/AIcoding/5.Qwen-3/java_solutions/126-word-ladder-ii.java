public class Solution {

import java.util.*;

public class Solution {
    public List<List<String>> findLadder(String beginWord, String endWord, List<String> wordList) {
        Set<String> wordSet = new HashSet<>(wordList);
        if (!wordSet.contains(endWord)) {
            return new ArrayList<>();
        }
        Map<String, List<String>> graph = new HashMap<>();
        Set<String> visited = new HashSet<>();
        Queue<String> queue = new LinkedList<>();
        queue.add(beginWord);
        visited.add(beginWord);
        boolean found = false;
        while (!queue.isEmpty() && !found) {
            int size = queue.size();
            Set<String> levelVisited = new HashSet<>();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                for (int j = 0; j < current.length(); j++) {
                    char[] chars = current.toCharArray();
                    for (char c = 'a'; c <= 'z'; c++) {
                        chars[j] = c;
                        String next = new String(chars);
                        if (wordSet.contains(next) && !visited.contains(next)) {
                            if (!graph.containsKey(current)) {
                                graph.put(current, new ArrayList<>());
                            }
                            graph.get(current).add(next);
                            if (next.equals(endWord)) {
                                found = true;
                            }
                            if (!levelVisited.contains(next)) {
                                queue.add(next);
                                levelVisited.add(next);
                            }
                        }
                    }
                }
            }
            visited.addAll(levelVisited);
        }
        List<List<String>> result = new ArrayList<>();
        List<String> path = new ArrayList<>();
        path.add(beginWord);
        dfs(beginWord, endWord, graph, path, result);
        return result;
    }

    private void dfs(String current, String end, Map<String, List<String>> graph, List<String> path, List<List<String>> result) {
        if (current.equals(end)) {
            result.add(new ArrayList<>(path));
            return;
        }
        if (!graph.containsKey(current)) {
            return;
        }
        for (String next : graph.get(current)) {
            path.add(next);
            dfs(next, end, graph, path, result);
            path.remove(path.size() - 1);
        }
    }
}
}