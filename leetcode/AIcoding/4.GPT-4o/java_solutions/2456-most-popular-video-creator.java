import java.util.*;

public class Solution {
    public List<List<String>> mostPopularCreator(String[] creators, String[] ids, int[] views) {
        Map<String, Long> totalViews = new HashMap<>();
        Map<String, String> maxVideo = new HashMap<>();
        Map<String, Long> maxViews = new HashMap<>();

        for (int i = 0; i < creators.length; i++) {
            totalViews.put(creators[i], totalViews.getOrDefault(creators[i], 0L) + views[i]);
            if (!maxVideo.containsKey(creators[i]) || views[i] > maxViews.get(creators[i])) {
                maxVideo.put(creators[i], ids[i]);
                maxViews.put(creators[i], (long) views[i]);
            } else if (views[i] == maxViews.get(creators[i]) && ids[i].compareTo(maxVideo.get(creators[i])) < 0) {
                maxVideo.put(creators[i], ids[i]);
            }
        }

        long maxTotalViews = Collections.max(totalViews.values());
        List<List<String>> result = new ArrayList<>();

        for (String creator : totalViews.keySet()) {
            if (totalViews.get(creator) == maxTotalViews) {
                result.add(Arrays.asList(creator, maxVideo.get(creator)));
            }
        }

        return result;
    }
}