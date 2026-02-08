import java.util.*;

class Twitter {
    private static class Tweet {
        int id;
        int time;

        Tweet(int id, int time) {
            this.id = id;
            this.time = time;
        }
    }

    private static class User {
        int id;
        Set<Integer> followers;
        List<Tweet> tweets;

        User(int id) {
            this.id = id;
            followers = new HashSet<>();
            tweets = new ArrayList<>();
        }
    }

    private Map<Integer, User> userMap;
    private int timeStamp;

    public Twitter() {
        userMap = new HashMap<>();
        timeStamp = 0;
    }

    public void postTweet(int userId, int tweetId) {
        if (!userMap.containsKey(userId)) {
            userMap.put(userId, new User(userId));
        }
        User user = userMap.get(userId);
        user.tweets.add(new Tweet(tweetId, timeStamp++));
    }

    public List<Integer> getNewsFeed(int userId) {
        List<Tweet> feed = new ArrayList<>();
        if (userMap.containsKey(userId)) {
            User user = userMap.get(userId);
            for (Tweet tweet : user.tweets) {
                feed.add(tweet);
            }
            for (int followerId : user.followers) {
                User follower = userMap.get(followerId);
                for (Tweet tweet : follower.tweets) {
                    feed.add(tweet);
                }
            }
        }
        feed.sort((a, b) -> b.time - a.time);
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < Math.min(feed.size(), 10); i++) {
            result.add(feed.get(i).id);
        }
        return result;
    }

    public void follow(int followerId, int followeeId) {
        if (!userMap.containsKey(followerId)) {
            userMap.put(followerId, new User(followerId));
        }
        if (!userMap.containsKey(followeeId)) {
            userMap.put(followeeId, new User(followeeId));
        }
        userMap.get(followerId).followers.add(followeeId);
    }

    public void unfollow(int followerId, int followeeId) {
        if (userMap.containsKey(followerId) && userMap.containsKey(followeeId)) {
            userMap.get(followerId).followers.remove(followeeId);
        }
    }
}