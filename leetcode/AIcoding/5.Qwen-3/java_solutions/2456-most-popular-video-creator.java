public class Solution {

import java.util.*;

class Solution {
    public List<List<String>> mostPopularCreator(String[] creators, String[] ids, int[] views) {
        Map<String, Integer> creatorMaxView = new HashMap<>();
        Map<String, List<String>> creatorVideos = new HashMap<>();
        int maxView = 0;

        for (int i = 0; i < creators.length; i++) {
            String creator = creators[i];
            String id = ids[i];
            int view = views[i];

            if (!creatorMaxView.containsKey(creator) || view > creatorMaxView.get(creator)) {
                creatorMaxView.put(creator, view);
                maxView = Math.max(maxView, view);
            }

            creatorVideos.computeIfAbsent(creator, k -> new ArrayList<>()).add(id);
        }

        List<List<String>> result = new ArrayList<>();

        for (Map.Entry<String, Integer> entry : creatorMaxView.entrySet()) {
            if (entry.getValue() == maxView) {
                String creator = entry.getKey();
                List<String> videos = creatorVideos.get(creator);
                Collections.sort(videos);
                result.add(Arrays.asList(creator, videos.get(0)));
            }
        }

        return result;
    }
}
}