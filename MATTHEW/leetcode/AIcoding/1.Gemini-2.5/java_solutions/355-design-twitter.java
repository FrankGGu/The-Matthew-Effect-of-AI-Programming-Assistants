import java.util.*;

class Tweet {
    public int tweetId;
    public int timestamp;

    public Tweet(int tweetId, int timestamp) {
        this.tweetId = tweetId;
        this.timestamp = timestamp;
    }
}

class Twitter {

    private static int timestamp = 0;

    private Map<Integer, Set<Integer>> userFollows;
    private Map<Integer, List<Tweet>> userTweets;

    public Twitter() {
        userFollows = new HashMap<>();
        userTweets = new HashMap<>();
        timestamp = 0;
    }

    public void postTweet(int userId, int tweetId) {
        userFollows.computeIfAbsent(userId, k -> new HashSet<>()).add(userId);
        userTweets.computeIfAbsent(userId, k -> new ArrayList<>()).add(new Tweet(tweetId, ++timestamp));
    }

    public List<Integer> getNewsFeed(int userId) {
        List<Integer> feed = new ArrayList<>();
        Set<Integer> followees = userFollows.getOrDefault(userId, new HashSet<>());
        followees.add(userId);

        PriorityQueue<Tweet> pq = new PriorityQueue<>((a, b) -> b.timestamp - a.timestamp);

        for (int followeeId : followees) {
            List<Tweet> tweets = userTweets.get(followeeId);
            if (tweets != null) {
                for (int i = tweets.size() - 1; i >= 0 && i >= tweets.size() - 10; i--) {
                    pq.offer(tweets.get(i));
                }
            }
        }

        while (!pq.isEmpty() && feed.size() < 10) {
            feed.add(pq.poll().tweetId);
        }
        return feed;
    }

    public void follow(int followerId, int followeeId) {
        userFollows.computeIfAbsent(followerId, k -> new HashSet<>()).add(followerId);
        userFollows.get(followerId).add(followeeId);
    }

    public void unfollow(int followerId, int followeeId) {
        if (followerId == followeeId) {
            return;
        }
        Set<Integer> followees = userFollows.get(followerId);
        if (followees != null) {
            followees.remove(followeeId);
        }
    }
}