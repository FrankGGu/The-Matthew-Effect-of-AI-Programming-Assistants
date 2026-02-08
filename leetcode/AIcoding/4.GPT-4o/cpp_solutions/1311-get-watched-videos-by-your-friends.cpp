#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

vector<string> watchedVideosByFriends(vector<vector<string>>& watchedVideos, vector<vector<int>>& friends, int id, int level) {
    unordered_map<string, int> videoCount;
    unordered_map<int, int> visited;
    vector<int> currentLevelFriends = {id};

    for (int i = 0; i < level; ++i) {
        vector<int> nextLevelFriends;
        for (int friendId : currentLevelFriends) {
            visited[friendId] = 1;
            for (int f : friends[friendId]) {
                if (!visited.count(f)) {
                    nextLevelFriends.push_back(f);
                }
            }
        }
        currentLevelFriends = nextLevelFriends;
    }

    for (int friendId : currentLevelFriends) {
        for (const string& video : watchedVideos[friendId]) {
            videoCount[video]++;
        }
    }

    vector<pair<string, int>> videoList(videoCount.begin(), videoCount.end());
    sort(videoList.begin(), videoList.end(), [](const pair<string, int>& a, const pair<string, int>& b) {
        return a.first < b.first;
    });

    vector<string> result;
    for (const auto& p : videoList) {
        result.push_back(p.first);
    }

    return result;
}