#include <vector>
#include <queue>
#include <unordered_set>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> watchedVideosByFriends(vector<vector<string>>& watchedVideos, vector<vector<int>>& friends, int id, int level) {
        queue<int> q;
        q.push(id);
        unordered_set<int> visited;
        visited.insert(id);

        int currentLevel = 0;
        vector<int> levelFriends;

        while (!q.empty() && currentLevel < level) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int u = q.front();
                q.pop();

                for (int v : friends[u]) {
                    if (visited.find(v) == visited.end()) {
                        visited.insert(v);
                        q.push(v);
                    }
                }
            }
            currentLevel++;
        }

        while (!q.empty()) {
            levelFriends.push_back(q.front());
            q.pop();
        }

        unordered_map<string, int> videoCount;
        for (int friendId : levelFriends) {
            for (const string& video : watchedVideos[friendId]) {
                videoCount[video]++;
            }
        }

        vector<pair<string, int>> videosWithCount(videoCount.begin(), videoCount.end());
        sort(videosWithCount.begin(), videosWithCount.end(), [](const pair<string, int>& a, const pair<string, int>& b) {
            if (a.second != b.second) {
                return a.second < b.second;
            } else {
                return a.first < b.first;
            }
        });

        vector<string> result;
        for (const auto& pair : videosWithCount) {
            result.push_back(pair.first);
        }

        return result;
    }
};