class Solution {
    public List<List<String>> findLadders(String beginWord, String endWord, List<String> wordList) {
        List<List<String>> res = new ArrayList<>();
        Set<String> dict = new HashSet<>(wordList);
        if (!dict.contains(endWord)) return res;

        Map<String, List<String>> neighbors = new HashMap<>();
        Map<String, Integer> distance = new HashMap<>();
        bfs(beginWord, endWord, dict, neighbors, distance);
        dfs(beginWord, endWord, neighbors, distance, new ArrayList<>(), res);
        return res;
    }

    private void bfs(String beginWord, String endWord, Set<String> dict, Map<String, List<String>> neighbors, Map<String, Integer> distance) {
        Queue<String> queue = new LinkedList<>();
        queue.offer(beginWord);
        distance.put(beginWord, 0);

        while (!queue.isEmpty()) {
            int size = queue.size();
            boolean foundEnd = false;
            for (int i = 0; i < size; i++) {
                String curr = queue.poll();
                int currDistance = distance.get(curr);
                List<String> currNeighbors = getNeighbors(curr, dict);
                for (String neighbor : currNeighbors) {
                    if (!distance.containsKey(neighbor)) {
                        distance.put(neighbor, currDistance + 1);
                        if (neighbor.equals(endWord)) {
                            foundEnd = true;
                        } else {
                            queue.offer(neighbor);
                        }
                    }
                }
                neighbors.put(curr, currNeighbors);
            }
            if (foundEnd) break;
        }
    }

    private List<String> getNeighbors(String word, Set<String> dict) {
        List<String> neighbors = new ArrayList<>();
        char[] chars = word.toCharArray();
        for (int i = 0; i < chars.length; i++) {
            char old = chars[i];
            for (char c = 'a'; c <= 'z'; c++) {
                if (c == old) continue;
                chars[i] = c;
                String newWord = new String(chars);
                if (dict.contains(newWord)) {
                    neighbors.add(newWord);
                }
            }
            chars[i] = old;
        }
        return neighbors;
    }

    private void dfs(String currWord, String endWord, Map<String, List<String>> neighbors, Map<String, Integer> distance, List<String> path, List<List<String>> res) {
        path.add(currWord);
        if (currWord.equals(endWord)) {
            res.add(new ArrayList<>(path));
        } else {
            for (String neighbor : neighbors.getOrDefault(currWord, new ArrayList<>())) {
                if (distance.getOrDefault(neighbor, 0) == distance.get(currWord) + 1) {
                    dfs(neighbor, endWord, neighbors, distance, path, res);
                }
            }
        }
        path.remove(path.size() - 1);
    }
}