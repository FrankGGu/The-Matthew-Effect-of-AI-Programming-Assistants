import java.util.*;

class Solution {
    public List<String> watchedVideosByFriends(List<List<String>> watchedVideos, int[][] friends, int id, int level) {
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(id);
        Set<Integer> visited = new HashSet<>();
        visited.add(id);

        for (int i = 0; i < level; i++) {
            int size = queue.size();
            for (int j = 0; j < size; j++) {
                int curr = queue.poll();
                for (int friend : friends[curr]) {
                    if (!visited.contains(friend)) {
                        queue.offer(friend);
                        visited.add(friend);
                    }
                }
            }
        }

        List<String> videos = new ArrayList<>();
        while (!queue.isEmpty()) {
            videos.addAll(watchedVideos.get(queue.poll()));
        }

        Map<String, Integer> videoCount = new HashMap<>();
        for (String video : videos) {
            videoCount.put(video, videoCount.getOrDefault(video, 0) + 1);
        }

        List<String> result = new ArrayList<>(videoCount.keySet());
        Collections.sort(result, (a, b) -> {
            int countA = videoCount.get(a);
            int countB = videoCount.get(b);
            if (countA != countB) {
                return countA - countB;
            } else {
                return a.compareTo(b);
            }
        });

        return result;
    }
}