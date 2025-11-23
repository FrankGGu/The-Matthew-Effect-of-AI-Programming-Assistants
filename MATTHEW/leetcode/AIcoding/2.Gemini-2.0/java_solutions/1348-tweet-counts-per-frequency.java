import java.util.*;

class TweetCounts {

    private Map<String, List<Integer>> tweetMap;

    public TweetCounts() {
        tweetMap = new HashMap<>();
    }

    public void recordTweet(String tweetName, int time) {
        tweetMap.computeIfAbsent(tweetName, k -> new ArrayList<>()).add(time);
    }

    public List<Integer> getTweetCountsPerFrequency(String freq, String tweetName, int startTime, int endTime) {
        int interval = 0;
        if (freq.equals("minute")) {
            interval = 60;
        } else if (freq.equals("hour")) {
            interval = 3600;
        } else {
            interval = 86400;
        }

        List<Integer> result = new ArrayList<>();
        List<Integer> tweets = tweetMap.getOrDefault(tweetName, new ArrayList<>());
        Collections.sort(tweets);

        int size = (endTime - startTime) / interval + 1;
        int[] counts = new int[size];

        for (int tweet : tweets) {
            if (tweet >= startTime && tweet <= endTime) {
                int index = (tweet - startTime) / interval;
                counts[index]++;
            }
        }

        for (int count : counts) {
            result.add(count);
        }

        return result;
    }
}