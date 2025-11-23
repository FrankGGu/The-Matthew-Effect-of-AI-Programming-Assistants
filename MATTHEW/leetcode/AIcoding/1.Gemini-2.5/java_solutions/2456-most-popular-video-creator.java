import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<List<String>> mostPopularCreator(String[] creators, String[] ids, int[] views) {
        Map<String, Long> creatorTotalViews = new HashMap<>();
        Map<String, String> creatorBestVideoId = new HashMap<>();
        Map<String, Integer> creatorBestVideoViews = new HashMap<>();

        for (int i = 0; i < creators.length; i++) {
            String creator = creators[i];
            String id = ids[i];
            int view = views[i];

            // Update total views for the creator
            creatorTotalViews.put(creator, creatorTotalViews.getOrDefault(creator, 0L) + view);

            // Update the most popular video for the creator
            int currentMaxViews = creatorBestVideoViews.getOrDefault(creator, -1);
            String currentBestId = creatorBestVideoId.getOrDefault(creator, "");

            if (view > currentMaxViews) {
                creatorBestVideoViews.put(creator, view);
                creatorBestVideoId.put(creator, id);
            } else if (view == currentMaxViews) {
                // If views are tied, choose the video with the lexicographically smallest ID
                if (id.compareTo(currentBestId) < 0) {
                    creatorBestVideoId.put(creator, id);
                }
            }
        }

        long maxOverallTotalViews = 0L;
        for (long totalViews : creatorTotalViews.values()) {
            maxOverallTotalViews = Math.max(maxOverallTotalViews, totalViews);
        }

        List<List<String>> result = new ArrayList<>();
        for (Map.Entry<String, Long> entry : creatorTotalViews.entrySet()) {
            String creator = entry.getKey();
            long totalViews = entry.getValue();

            if (totalViews == maxOverallTotalViews) {
                String bestVideoId = creatorBestVideoId.get(creator);
                result.add(Arrays.asList(creator, bestVideoId));
            }
        }

        return result;
    }
}