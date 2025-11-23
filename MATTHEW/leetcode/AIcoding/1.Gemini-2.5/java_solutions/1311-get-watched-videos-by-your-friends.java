import java.util.*;

class Solution {
    public List<String> watchedVideosByFriends(List<List<String>> watchedVideos, int[][] friends, int id, int level) {
        int n = watchedVideos.size();

        Queue<Integer> q = new LinkedList<>();
        boolean[] visited = new boolean[n];

        q.offer(id);
        visited[id] = true;

        int currentLevel = 0;
        Set<Integer> levelKFriends = new HashSet<>();

        while (!q.isEmpty() && currentLevel <= level) {
            int levelSize = q.size();
            for (int i = 0; i < levelSize; i++) {
                int currentPerson = q.poll();

                if (currentLevel == level) {
                    levelKFriends.add(currentPerson);
                }

                for (int friend : friends[currentPerson]) {
                    if (!visited[friend]) {
                        visited[friend] = true;
                        q.offer(friend);
                    }
                }
            }
            currentLevel++;
        }

        Map<String, Integer> videoCounts = new HashMap<>();
        for (int friendId : levelKFriends) {
            for (String video : watchedVideos.get(friendId)) {
                videoCounts.put(video, videoCounts.getOrDefault(video, 0) + 1);
            }
        }

        List<Map.Entry<String, Integer>> sortedVideoEntries = new ArrayList<>(videoCounts.entrySet());

        Collections.sort(sortedVideoEntries, (e1, e2) -> {
            int freqCompare = e1.getValue().compareTo(e2.getValue());
            if (freqCompare == 0) {
                return e1.getKey().compareTo(e2.getKey());
            }
            return freqCompare;
        });

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : sortedVideoEntries) {
            result.add(entry.getKey());
        }

        return result;
    }
}