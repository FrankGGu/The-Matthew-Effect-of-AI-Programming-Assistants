#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <queue>
#include <algorithm>

class Twitter {
private:
    std::unordered_map<int, std::vector<std::pair<int, int>>> user_tweets;
    std::unordered_map<int, std::unordered_set<int>> following;
    int time_stamp;

public:
    Twitter() {
        time_stamp = 0;
    }

    void postTweet(int userId, int tweetId) {
        time_stamp++;
        user_tweets[userId].push_back({time_stamp, tweetId});
        following[userId].insert(userId); // A user always follows themselves
    }

    std::vector<int> getNewsFeed(int userId) {
        std::priority_queue<std::pair<int, int>> pq; // Max-heap for {timestamp, tweetId}

        if (following.count(userId)) {
            for (int followeeId : following[userId]) {
                if (user_tweets.count(followeeId)) {
                    // Iterate through the followee's tweets from most recent (end of vector)
                    // We only need to consider up to the last 10 tweets from each followee
                    // because we only want the top 10 overall.
                    for (int i = user_tweets[followeeId].size() - 1; 
                         i >= 0 && i >= (int)user_tweets[followeeId].size() - 10; 
                         --i) {
                        pq.push(user_tweets[followeeId][i]);
                    }
                }
            }
        }

        std::vector<int> newsFeed;
        while (!pq.empty() && newsFeed.size() < 10) {
            newsFeed.push_back(pq.top().second);
            pq.pop();
        }

        return newsFeed;
    }

    void follow(int followerId, int followeeId) {
        following[followerId].insert(followeeId);
        following[followerId].insert(followerId); // Ensure follower always follows themselves
    }

    void unfollow(int followerId, int followeeId) {
        if (followerId == followeeId) { // A user cannot unfollow themselves
            return;
        }
        if (following.count(followerId)) {
            following[followerId].erase(followeeId);
        }
    }
};