class Solution {
    public List<String> watchedVideosByFriends(List<List<String>> watchedVideos, int[][] friends, int id, int level) {
        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[friends.length];
        queue.offer(id);
        visited[id] = true;
        int currentLevel = 0;

        while (!queue.isEmpty() && currentLevel < level) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int current = queue.poll();
                for (int friend : friends[current]) {
                    if (!visited[friend]) {
                        visited[friend] = true;
                        queue.offer(friend);
                    }
                }
            }
            currentLevel++;
        }

        Map<String, Integer> frequency = new HashMap<>();
        while (!queue.isEmpty()) {
            int person = queue.poll();
            for (String video : watchedVideos.get(person)) {
                frequency.put(video, frequency.getOrDefault(video, 0) + 1);
            }
        }

        List<String> result = new ArrayList<>(frequency.keySet());
        result.sort((a, b) -> {
            int freqA = frequency.get(a);
            int freqB = frequency.get(b);
            if (freqA != freqB) {
                return freqA - freqB;
            } else {
                return a.compareTo(b);
            }
        });

        return result;
    }
}