class TweetCounts {
    private Map<String, TreeMap<Integer, Integer>> map;

    public TweetCounts() {
        map = new HashMap<>();
    }

    public void recordTweet(String tweetName, int time) {
        if (!map.containsKey(tweetName)) {
            map.put(tweetName, new TreeMap<>());
        }
        TreeMap<Integer, Integer> tweetMap = map.get(tweetName);
        tweetMap.put(time, tweetMap.getOrDefault(time, 0) + 1);
    }

    public List<Integer> getTweetCountsPerFrequency(String freq, String tweetName, int startTime, int endTime) {
        List<Integer> res = new ArrayList<>();
        if (!map.containsKey(tweetName)) return res;

        int interval = 0;
        if (freq.equals("minute")) {
            interval = 60;
        } else if (freq.equals("hour")) {
            interval = 3600;
        } else if (freq.equals("day")) {
            interval = 86400;
        }

        TreeMap<Integer, Integer> tweetMap = map.get(tweetName);
        int start = startTime;
        while (start <= endTime) {
            int end = Math.min(start + interval - 1, endTime);
            Map.Entry<Integer, Integer> entry = tweetMap.ceilingEntry(start);
            int count = 0;
            while (entry != null && entry.getKey() <= end) {
                count += entry.getValue();
                entry = tweetMap.higherEntry(entry.getKey());
            }
            res.add(count);
            start = end + 1;
        }

        return res;
    }
}