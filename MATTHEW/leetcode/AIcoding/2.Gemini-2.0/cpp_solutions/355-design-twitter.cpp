#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Twitter {
public:
    Twitter() {
        time = 0;
    }

    void postTweet(int userId, int tweetId) {
        tweets[userId].push_back({time++, tweetId});
    }

    vector<int> getNewsFeed(int userId) {
        vector<pair<int, int>> feed;
        unordered_set<int> followed = followers[userId];
        followed.insert(userId);

        for (int user : followed) {
            for (auto tweet : tweets[user]) {
                feed.push_back(tweet);
            }
        }

        sort(feed.begin(), feed.end(), greater<pair<int, int>>());

        vector<int> result;
        int count = 0;
        for (auto tweet : feed) {
            result.push_back(tweet.second);
            count++;
            if (count == 10) {
                break;
            }
        }

        return result;
    }

    void follow(int followerId, int followeeId) {
        followers[followerId].insert(followeeId);
    }

    void unfollow(int followerId, int followeeId) {
        followers[followerId].erase(followeeId);
    }

private:
    unordered_map<int, vector<pair<int, int>>> tweets;
    unordered_map<int, unordered_set<int>> followers;
    int time;
};