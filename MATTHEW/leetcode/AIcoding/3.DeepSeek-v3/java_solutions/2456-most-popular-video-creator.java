class Solution {
    public List<List<String>> mostPopularCreator(String[] creators, String[] ids, int[] views) {
        Map<String, Long> popularity = new HashMap<>();
        Map<String, Integer> maxView = new HashMap<>();
        Map<String, String> maxId = new HashMap<>();

        long maxPopularity = Long.MIN_VALUE;

        for (int i = 0; i < creators.length; i++) {
            String creator = creators[i];
            String id = ids[i];
            int view = views[i];

            popularity.put(creator, popularity.getOrDefault(creator, 0L) + view);

            if (!maxView.containsKey(creator) || maxView.get(creator) < view || 
                (maxView.get(creator) == view && id.compareTo(maxId.get(creator)) < 0) {
                maxView.put(creator, view);
                maxId.put(creator, id);
            }

            maxPopularity = Math.max(maxPopularity, popularity.get(creator));
        }

        List<List<String>> result = new ArrayList<>();
        for (String creator : popularity.keySet()) {
            if (popularity.get(creator) == maxPopularity) {
                List<String> entry = new ArrayList<>();
                entry.add(creator);
                entry.add(maxId.get(creator));
                result.add(entry);
            }
        }

        return result;
    }
}