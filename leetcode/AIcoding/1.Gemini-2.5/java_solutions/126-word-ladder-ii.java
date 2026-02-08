import java.util.*;

class Solution {
    public List<List<String>> findLadders(String beginWord, String endWord, List<String> wordList) {
        List<List<String>> results = new ArrayList<>();
        Set<String> dict = new HashSet<>(wordList);

        if (!dict.contains(endWord)) {
            return results;
        }

        Map<String, Integer> dist = new HashMap<>(); // Stores shortest distance from beginWord to each word
        Map<String, List<String>> prevs = new HashMap<>(); // Stores predecessors for each word on shortest paths
        Queue<String> q = new LinkedList<>();

        q.offer(beginWord);
        dist.put(beginWord, 0);
        boolean foundEnd = false;

        // BFS to build distance map and predecessor map
        while (!q.isEmpty()) {
            Set<String> nextLevelWords = new HashSet<>(); // Words to be processed in the next level
            int levelSize = q.size();

            for (int i = 0; i < levelSize; i++) {
                String currWord = q.poll();

                if (currWord.equals(endWord)) {
                    foundEnd = true;
                }

                char[] charArray = currWord.toCharArray();
                for (int j = 0; j < charArray.length; j++) {
                    char originalChar = charArray[j];
                    for (char c = 'a'; c <= 'z'; c++) {
                        if (c == originalChar) {
                            continue;
                        }
                        charArray[j] = c;
                        String nextWord = new String(charArray);

                        if (dict.contains(nextWord)) {
                            if (!dist.containsKey(nextWord)) {
                                // First time reaching nextWord on a shortest path
                                dist.put(nextWord, dist.get(currWord) + 1);
                                prevs.computeIfAbsent(nextWord, k -> new ArrayList<>()).add(currWord);
                                nextLevelWords.add(nextWord);
                            } else if (dist.get(nextWord) == dist.get(currWord) + 1) {
                                // Another shortest path to nextWord found
                                prevs.computeIfAbsent(nextWord, k -> new ArrayList<>()).add(currWord);
                            }
                        }
                    }
                    charArray[j] = originalChar; // Backtrack char change
                }
            }

            // Add all words discovered in this level to the queue for the next level
            for (String word : nextLevelWords) {
                q.offer(word);
            }

            // If endWord was found in this level, we have found all shortest paths.
            // Any paths found in subsequent levels would be longer.
            if (foundEnd) {
                break;
            }
        }

        // If endWord was not reachable, return empty results
        if (!dist.containsKey(endWord)) {
            return results;
        }

        // DFS to reconstruct all shortest paths
        LinkedList<String> currentPath = new LinkedList<>();
        dfs(endWord, beginWord, prevs, currentPath, results);

        return results;
    }

    private void dfs(String word, String beginWord, Map<String, List<String>> prevs,
                     LinkedList<String> currentPath, List<List<String>> results) {
        currentPath.addFirst(word); // Add to the beginning as we are building path in reverse

        if (word.equals(beginWord)) {
            results.add(new ArrayList<>(currentPath));
        } else if (prevs.containsKey(word)) {
            for (String prevWord : prevs.get(word)) {
                dfs(prevWord, beginWord, prevs, currentPath, results);
            }
        }
        currentPath.removeFirst(); // Backtrack
    }
}