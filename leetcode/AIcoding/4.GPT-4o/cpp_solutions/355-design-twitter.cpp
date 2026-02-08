#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <queue>

using namespace std;

class Twitter {
public:
    Twitter() {
        timeStamp = 0;
    }

    void postTweet(int userId, int tweetId) {
        tweets[userId].push_back({timeStamp++, tweetId});
        if (userFollowings.find(userId) == userFollowings.end()) {
            userFollowings[userId] = unordered_set<int>();
        }
    }

    vector<int> getNewsFeed(int userId) {
        priority_queue<pair<int, int>> pq;
        if (tweets.find(userId) != tweets.end()) {
            for (const auto& tweet : tweets[userId]) {
                pq.push(tweet);
            }
        }
        for (int followee : userFollowings[userId]) {
            if (tweets.find(followee) != tweets.end()) {
                for (const auto& tweet : tweets[followee]) {
                    pq.push(tweet);
                }
            }
        }

        vector<int> feed;
        for (int i = 0; i < 10 && !pq.empty(); i++) {
            feed.push_back(pq.top().second);
            pq.pop();
        }
        return feed;
    }

    void follow(int followerId, int followeeId) {
        userFollowings[followerId].insert(followeeId);
    }

    void unfollow(int followerId, int followeeId) {
        if (userFollowings.find(followerId) != userFollowings.end()) {
            userFollowings[followerId].erase(followeeId);
        }
    }

private:
    unordered_map<int, vector<pair<int, int>>> tweets;
    unordered_map<int, unordered_set<int>> userFollowings;
    int timeStamp;
};