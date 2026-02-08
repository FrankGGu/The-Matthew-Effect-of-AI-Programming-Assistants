class Twitter {
private:
    struct Tweet {
        int id;
        int time;
        Tweet(int id, int time) : id(id), time(time) {}
    };

    unordered_map<int, vector<Tweet>> userTweets;
    unordered_map<int, unordered_set<int>> following;
    int time;

public:
    Twitter() {
        time = 0;
    }

    void postTweet(int userId, int tweetId) {
        userTweets[userId].emplace_back(tweetId, time++);
    }

    vector<int> getNewsFeed(int userId) {
        vector<int> feed;
        priority_queue<pair<int, int>> maxHeap;

        following[userId].insert(userId);
        for (int followeeId : following[userId]) {
            for (const Tweet& tweet : userTweets[followeeId]) {
                maxHeap.push({tweet.time, tweet.id});
            }
        }

        while (!maxHeap.empty() && feed.size() < 10) {
            feed.push_back(maxHeap.top().second);
            maxHeap.pop();
        }

        return feed;
    }

    void follow(int followerId, int followeeId) {
        following[followerId].insert(followeeId);
    }

    void unfollow(int followerId, int followeeId) {
        following[followerId].erase(followeeId);
    }
};