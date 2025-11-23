#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <queue>

using namespace std;

class Solution {
public:
    vector<string> getWatchedVideosByYourFriends(vector<vector<int>> &friends, vector<vector<string>> &videos, int id) {
        map<string, int> videoCount;
        set<int> visited;
        queue<int> q;
        q.push(id);
        visited.insert(id);

        while (!q.empty()) {
            int current = q.front();
            q.pop();
            for (int friendId : friends[current]) {
                if (visited.find(friendId) == visited.end()) {
                    visited.insert(friendId);
                    q.push(friendId);
                    for (string video : videos[friendId]) {
                        videoCount[video]++;
                    }
                }
            }
        }

        vector<pair<int, string>> result;
        for (auto &entry : videoCount) {
            result.push_back({entry.second, entry.first});
        }

        sort(result.begin(), result.end());
        vector<string> output;
        for (auto &pair : result) {
            output.push_back(pair.second);
        }

        return output;
    }
};