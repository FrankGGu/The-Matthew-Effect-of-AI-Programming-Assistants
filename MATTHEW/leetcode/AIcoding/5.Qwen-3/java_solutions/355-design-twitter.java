public class Solution {

import java.util.*;

public class Twitter {
    private int time;
    private Map<Integer, Set<Integer>> followMap;
    private Map<Integer, List<int[]>> tweetMap;

    public Twitter() {
        time = 0;
        followMap = new HashMap<>();
        tweetMap = new HashMap<>();
    }

    public void postTweet(int userId, int tweetId) {
        tweetMap.putIfAbsent(userId, new ArrayList<>());
        tweetMap.get(userId).add(new int[]{time++, tweetId});
    }

    public List<Integer> getNewsFeed(int userId) {
        PriorityQueue<int[]> maxHeap = new PriorityQueue<>((a, b) -> b[0] - a[0]);
        if (followMap.containsKey(userId)) {
            for (int followeeId : followMap.get(userId)) {
                if (tweetMap.containsKey(followeeId)) {
                    List<int[]> tweets = tweetMap.get(followeeId);
                    if (!tweets.isEmpty()) {
                        maxHeap.offer(tweets.get(tweets.size() - 1));
                    }
                }
            }
        }
        if (tweetMap.containsKey(userId)) {
            List<int[]> tweets = tweetMap.get(userId);
            if (!tweets.isEmpty()) {
                maxHeap.offer(tweets.get(tweets.size() - 1));
            }
        }

        List<Integer> result = new ArrayList<>();
        while (!maxHeap.isEmpty() && result.size() < 10) {
            int[] tweet = maxHeap.poll();
            result.add(tweet[1]);
            int userIdOfTweet = tweet[1];
            int index = tweet[0];
            if (index > 0) {
                maxHeap.offer(new int[]{index - 1, userIdOfTweet});
            }
        }
        return result;
    }

    public void follow(int followerId, int followeeId) {
        followMap.putIfAbsent(followerId, new HashSet<>());
        followMap.get(followerId).add(followeeId);
    }

    public void unfollow(int followerId, int followeeId) {
        if (followMap.containsKey(followerId)) {
            followMap.get(followerId).remove(followeeId);
        }
    }
}
}