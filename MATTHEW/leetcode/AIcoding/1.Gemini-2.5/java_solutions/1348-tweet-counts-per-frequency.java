import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class TweetCounts {

    private Map<String, List<Integer>> tweetTimes;

    public TweetCounts() {
        tweetTimes = new HashMap<>();
    }

    public void recordTweet(String tweetName, int time) {
        tweetTimes.computeIfAbsent(tweetName, k -> new ArrayList<>()).add(time);
    }

    public List<Integer> getTweetCountsPerFrequency(String freq, String tweetName, int startTime, int intEndTime) {
        int intervalSize;
        switch (freq) {
            case "minute":
                intervalSize = 60;
                break;
            case "hour":
                intervalSize = 3600;
                break;
            case "day":
                intervalSize = 86400;
                break;
            default:
                throw new IllegalArgumentException("Invalid frequency: " + freq);
        }

        // Calculate the number of intervals needed for the range [startTime, intEndTime]
        // The number of intervals is (total_duration / intervalSize) + 1
        // For example, if startTime=0, intEndTime=59, intervalSize=60, then (59-0)/60 + 1 = 1 interval [0, 59].
        // If startTime=0, intEndTime=60, intervalSize=60, then (60-0)/60 + 1 = 2 intervals [0, 59], [60, 119].
        int numIntervals = (intEndTime - startTime) / intervalSize + 1;
        List<Integer> counts = new ArrayList<>(numIntervals);
        for (int i = 0; i < numIntervals; i++) {
            counts.add(0); // Initialize all counts to zero
        }

        List<Integer> times = tweetTimes.get(tweetName);

        if (times == null) {
            return counts; // No tweets for this name, return list of zeros
        }

        for (int time : times) {
            // Check if the tweet falls within the query time range [startTime, intEndTime]
            if (time >= startTime && time <= intEndTime) {
                // Calculate which interval this tweet belongs to
                // The interval index is relative to startTime
                int intervalIndex = (time - startTime) / intervalSize;

                // Increment the count for the corresponding interval
                // The intervalIndex will always be within bounds [0, numIntervals-1]
                // because time is within [startTime, intEndTime]
                counts.set(intervalIndex, counts.get(intervalIndex) + 1);
            }
        }

        return counts;
    }
}