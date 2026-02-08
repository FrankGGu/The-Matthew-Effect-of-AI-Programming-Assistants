import java.util.*;

public class Solution {
    public List<String> watchedVideosByFriends(List<List<String>> watchedVideos, int[][] friends, int id, int level) {
        Set<Integer> visited = new HashSet<>();
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(id);
        visited.add(id);

        for (int i = 0; i < level; i++) {
            int size = queue.size();
            for (int j = 0; j < size; j++) {
                int friend = queue.poll();
                for (int f : friends[friend]) {
                    if (!visited.contains(f)) {
                        visited.add(f);
                        queue.offer(f);
                    }
                }
            }
        }

        Map<String, Integer> videoCount = new HashMap<>();
        while (!queue.isEmpty()) {
            int friend = queue.poll();
            for (String video : watchedVideos.get(friend)) {
                videoCount.put(video, videoCount.getOrDefault(video, 0) + 1);
            }
        }

        List<String> result = new ArrayList<>(videoCount.keySet());
        result.sort((a, b) -> videoCount.get(a) == videoCount.get(b) ? a.compareTo(b) : videoCount.get(a) - videoCount.get(b));

        return result;
    }
}