public class Solution {

import java.util.*;

public class Solution {
    public List<String> getWatchedVideosByYourFriends(List<List<String>> friends, List<List<String>> watchedVideos, int id, int minMinutes) {
        Set<Integer> visited = new HashSet<>();
        Queue<Integer> queue = new LinkedList<>();
        queue.add(id);
        visited.add(id);

        List<String> result = new ArrayList<>();

        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (String video : watchedVideos.get(current)) {
                if (video.length() >= minMinutes) {
                    result.add(video);
                }
            }
            for (int friend : friends.get(current)) {
                if (!visited.contains(friend)) {
                    visited.add(friend);
                    queue.add(friend);
                }
            }
        }

        Collections.sort(result);
        return result;
    }
}
}