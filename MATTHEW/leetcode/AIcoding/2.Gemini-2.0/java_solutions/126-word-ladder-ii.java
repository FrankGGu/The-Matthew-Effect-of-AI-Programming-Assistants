import java.util.*;

public class Solution {
    public List<List<String>> findLadders(String beginWord, String endWord, List<String> wordList) {
        List<List<String>> res = new ArrayList<>();
        Set<String> wordSet = new HashSet<>(wordList);
        if (!wordSet.contains(endWord)) return res;

        Queue<List<String>> queue = new LinkedList<>();
        queue.offer(Arrays.asList(beginWord));
        Set<String> visited = new HashSet<>();
        visited.add(beginWord);
        boolean found = false;

        while (!queue.isEmpty() && !found) {
            int size = queue.size();
            Set<String> currentLevelVisited = new HashSet<>();

            for (int i = 0; i < size; i++) {
                List<String> path = queue.poll();
                String lastWord = path.get(path.size() - 1);

                List<String> neighbors = getNeighbors(lastWord, wordSet);
                for (String neighbor : neighbors) {
                    if (!visited.contains(neighbor)) {
                        List<String> newPath = new ArrayList<>(path);
                        newPath.add(neighbor);
                        if (neighbor.equals(endWord)) {
                            res.add(newPath);
                            found = true;
                        } else {
                            queue.offer(newPath);
                            currentLevelVisited.add(neighbor);
                        }
                    }
                }
            }
            visited.addAll(currentLevelVisited);
        }

        return res;
    }

    private List<String> getNeighbors(String word, Set<String> wordSet) {
        List<String> neighbors = new ArrayList<>();
        char[] chars = word.toCharArray();
        for (int i = 0; i < chars.length; i++) {
            char originalChar = chars[i];
            for (char c = 'a'; c <= 'z'; c++) {
                if (c == originalChar) continue;
                chars[i] = c;
                String newWord = new String(chars);
                if (wordSet.contains(newWord)) {
                    neighbors.add(newWord);
                }
            }
            chars[i] = originalChar;
        }
        return neighbors;
    }
}