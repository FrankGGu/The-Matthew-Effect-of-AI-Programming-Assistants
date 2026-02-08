import java.util.*;

class Twitter {

    private static int timestamp = 0;
    private Map<Integer, User> userMap;

    public Twitter() {
        userMap = new HashMap<>();
    }

    public void postTweet(int userId, int tweetId) {
        if (!userMap.containsKey(userId)) {
            userMap.put(userId, new User(userId));
        }
        userMap.get(userId).post(tweetId);
    }

    public List<Integer> getNewsFeed(int userId) {
        List<Integer> res = new ArrayList<>();
        if (!userMap.containsKey(userId)) {
            return res;
        }

        Set<Integer> followeeIdSet = userMap.get(userId).followed;
        followeeIdSet.add(userId);

        PriorityQueue<Tweet> pq = new PriorityQueue<>((a, b) -> (b.time - a.time));

        for (int followeeId : followeeIdSet) {
            if (!userMap.containsKey(followeeId)) continue;
            User followee = userMap.get(followeeId);
            if (!followee.tweets.isEmpty()) {
                for (Tweet tweet : followee.tweets) {
                    pq.add(tweet);
                }
            }
        }

        int n = 0;
        while (!pq.isEmpty() && n < 10) {
            Tweet tweet = pq.poll();
            res.add(tweet.id);
            n++;
        }
        return res;
    }

    public void follow(int followerId, int followeeId) {
        if (!userMap.containsKey(followerId)) {
            userMap.put(followerId, new User(followerId));
        }
        if (!userMap.containsKey(followeeId)) {
            userMap.put(followeeId, new User(followeeId));
        }
        userMap.get(followerId).follow(followeeId);
    }

    public void unfollow(int followerId, int followeeId) {
        if (!userMap.containsKey(followerId) || followerId == followeeId) {
            return;
        }
        userMap.get(followerId).unfollow(followeeId);
    }

    private class User {
        public int id;
        public Set<Integer> followed;
        public List<Tweet> tweets;

        public User(int userId) {
            id = userId;
            followed = new HashSet<>();
            tweets = new ArrayList<>();
        }

        public void follow(int userId) {
            followed.add(userId);
        }

        public void unfollow(int userId) {
            followed.remove(userId);
        }

        public void post(int tweetId) {
            tweets.add(0, new Tweet(tweetId, timestamp++));
            if (tweets.size() > 10) {
                tweets.remove(tweets.size() - 1);
            }
        }
    }

    private class Tweet {
        public int id;
        public int time;

        public Tweet(int id, int time) {
            this.id = id;
            this.time = time;
        }
    }
}