public class Solution {

import java.util.*;

public class Solution {
    public int ladderLength(String beginWord, String endWord, List<String> wordList) {
        Set<String> wordSet = new HashSet<>(wordList);
        if (!wordSet.contains(endWord)) {
            return 0;
        }
        Map<String, List<String>> map = new HashMap<>();
        for (String word : wordSet) {
            for (int i = 0; i < word.length(); i++) {
                String key = word.substring(0, i) + '*' + word.substring(i + 1);
                map.putIfAbsent(key, new ArrayList<>());
                map.get(key).add(word);
            }
        }
        Queue<String> queue = new LinkedList<>();
        queue.offer(beginWord);
        Set<String> visited = new HashSet<>();
        visited.add(beginWord);
        int level = 1;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (current.equals(endWord)) {
                    return level;
                }
                for (int j = 0; j < current.length(); j++) {
                    String key = current.substring(0, j) + '*' + current.substring(j + 1);
                    if (map.containsKey(key)) {
                        for (String neighbor : map.get(key)) {
                            if (!visited.contains(neighbor)) {
                                visited.add(neighbor);
                                queue.offer(neighbor);
                            }
                        }
                    }
                }
            }
            level++;
        }
        return 0;
    }
}
}