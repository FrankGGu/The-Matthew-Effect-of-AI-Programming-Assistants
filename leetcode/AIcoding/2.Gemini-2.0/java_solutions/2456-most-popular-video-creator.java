import java.util.*;

class Solution {
    public List<String> mostPopularCreator(String[] creators, String[] ids, int[] views) {
        Map<String, Long> creatorViews = new HashMap<>();
        Map<String, String> creatorBestVideo = new HashMap<>();
        Map<String, Integer> creatorBestVideoViews = new HashMap<>();

        for (int i = 0; i < creators.length; i++) {
            String creator = creators[i];
            String id = ids[i];
            int view = views[i];

            creatorViews.put(creator, creatorViews.getOrDefault(creator, 0L) + view);

            if (!creatorBestVideoViews.containsKey(creator) || view > creatorBestVideoViews.get(creator)) {
                creatorBestVideoViews.put(creator, view);
                creatorBestVideo.put(creator, id);
            } else if (view == creatorBestVideoViews.get(creator)) {
                if (id.compareTo(creatorBestVideo.get(creator)) < 0) {
                    creatorBestVideo.put(creator, id);
                }
            }
        }

        long maxView = 0;
        for (long view : creatorViews.values()) {
            maxView = Math.max(maxView, view);
        }

        List<String> result = new ArrayList<>();
        for (String creator : creatorViews.keySet()) {
            if (creatorViews.get(creator) == maxView) {
                result.add(creator);
            }
        }

        return result;
    }
}