#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <queue>
#include <set>

using namespace std;

class Solution {
public:
    class Tweet {
    public:
        int tweetId;
        int timestamp;
        Tweet* next;
        Tweet(int id, int ts) : tweetId(id), timestamp(ts), next(nullptr) {}
    };

    class User {
    public:
        unordered_set<int> followees;
        vector<Tweet*> tweets;
        User() {}
    };

    unordered_map<int, User*> users;
    int time;

    void postTweet(int userId, int tweetId) {
        if (users.find(userId) == users.end()) {
            users[userId] = new User();
        }
        Tweet* newTweet = new Tweet(tweetId, time++);
        newTweet->next = users[userId]->tweets.empty() ? nullptr : users[userId]->tweets.back();
        users[userId]->tweets.push_back(newTweet);
    }

    vector<int> getNewsFeed(int userId) {
        vector<int> result;
        if (users.find(userId) == users.end()) return result;

        priority_queue<pair<int, Tweet*>, vector<pair<int, Tweet*>>, greater<pair<int, Tweet*>>> maxHeap;

        for (int followeeId : users[userId]->followees) {
            if (users.find(followeeId) != users.end()) {
                for (auto tweet : users[followeeId]->tweets) {
                    maxHeap.push({tweet->timestamp, tweet});
                }
            }
        }

        for (auto tweet : users[userId]->tweets) {
            maxHeap.push({tweet->timestamp, tweet});
        }

        while (!maxHeap.empty() && result.size() < 10) {
            result.push_back(maxHeap.top().second->tweetId);
            maxHeap.pop();
        }

        return result;
    }

    void follow(int followerId, int followeeId) {
        if (followerId == followeeId) return;

        if (users.find(followerId) == users.end()) {
            users[followerId] = new User();
        }
        users[followerId]->followees.insert(followeeId);
    }

    void unfollow(int followerId, int followeeId) {
        if (users.find(followerId) == users.end()) return;
        users[followerId]->followees.erase(followeeId);
    }
};