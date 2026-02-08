import java.util.*;

class TweetCounts {
    private Map<String, List<Integer>> tweetMap;

    public TweetCounts() {
        tweetMap = new HashMap<>();
    }

    public void recordTweet(String tweetName, int time) {
        tweetMap.putIfAbsent(tweetName, new ArrayList<>());
        tweetMap.get(tweetName).add(time);
    }

    public List<Integer> getTweetCountsPerFrequency(String freq, String tweetName, int startTime, int endTime) {
        List<Integer> result = new ArrayList<>();
        List<Integer> times = tweetMap.getOrDefault(tweetName, new ArrayList<>());
        int interval = 0;

        switch (freq) {
            case "minute":
                interval = 60;
                break;
            case "hour":
                interval = 3600;
                break;
            case "day":
                interval = 86400;
                break;
        }

        int[] counts = new int[(endTime - startTime + 1) / interval + 1];

        for (int time : times) {
            if (time >= startTime && time <= endTime) {
                counts[(time - startTime) / interval]++;
            }
        }

        for (int count : counts) {
            result.add(count);
        }

        return result;
    }
}