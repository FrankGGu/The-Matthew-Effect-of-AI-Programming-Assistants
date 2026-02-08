import java.util.*;

class Solution {
    public int ladderLength(String beginWord, String endWord, List<String> wordList) {
        Set<String> wordSet = new HashSet<>(wordList);
        if (!wordSet.contains(endWord)) {
            return 0;
        }

        Queue<String> queue = new LinkedList<>();
        queue.offer(beginWord);
        Set<String> visited = new HashSet<>();
        visited.add(beginWord);

        int level = 1;

        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            for (int i = 0; i < levelSize; i++) {
                String currentWord = queue.poll();

                if (currentWord.equals(endWord)) {
                    return level;
                }

                for (int j = 0; j < currentWord.length(); j++) {
                    char[] charArray = currentWord.toCharArray();
                    char originalChar = charArray[j];

                    for (char c = 'a'; c <= 'z'; c++) {
                        charArray[j] = c;
                        String newWord = new String(charArray);

                        if (wordSet.contains(newWord) && !visited.contains(newWord)) {
                            visited.add(newWord);
                            queue.offer(newWord);
                        }
                    }
                    charArray[j] = originalChar; // Restore for next position, though not strictly needed with charArray copy
                }
            }
            level++;
        }

        return 0;
    }
}