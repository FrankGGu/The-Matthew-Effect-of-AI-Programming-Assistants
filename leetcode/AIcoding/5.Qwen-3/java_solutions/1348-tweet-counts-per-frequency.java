public class Solution {

import java.util.*;

public class TweetCounts {
    private Map<String, List<Integer>> tweetMap;

    public TweetCounts() {
        tweetMap = new HashMap<>();
    }

    public void recordTweet(String tweetName, int time) {
        tweetMap.putIfAbsent(tweetName, new ArrayList<>());
        tweetMap.get(tweetName).add(time);
    }

    public List<Integer> getTweetCounts(String tweetName, String freq, int startTime, int endTime) {
        List<Integer> result = new ArrayList<>();
        List<Integer> times = tweetMap.get(tweetName);
        if (times == null) {
            return result;
        }

        int interval = 0;
        if (freq.equals("minute")) {
            interval = 60;
        } else if (freq.equals("hour")) {
            interval = 3600;
        } else if (freq.equals("day")) {
            interval = 86400;
        }

        int currentStart = startTime;
        while (currentStart <= endTime) {
            int count = 0;
            int nextStart = currentStart + interval;
            for (int time : times) {
                if (time >= currentStart && time < nextStart) {
                    count++;
                }
            }
            result.add(count);
            currentStart = nextStart;
        }

        return result;
    }
}
}