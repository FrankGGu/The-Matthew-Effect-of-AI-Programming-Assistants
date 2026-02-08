class Solution {
public:
    vector<string> watchedVideosByFriends(vector<vector<string>>& watchedVideos, vector<vector<int>>& friends, int id, int level) {
        int n = friends.size();
        vector<bool> visited(n, false);
        queue<int> q;
        q.push(id);
        visited[id] = true;
        int currentLevel = 0;

        while (!q.empty() && currentLevel < level) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int current = q.front();
                q.pop();
                for (int friendId : friends[current]) {
                    if (!visited[friendId]) {
                        visited[friendId] = true;
                        q.push(friendId);
                    }
                }
            }
            currentLevel++;
        }

        unordered_map<string, int> videoCount;
        while (!q.empty()) {
            int current = q.front();
            q.pop();
            for (string video : watchedVideos[current]) {
                videoCount[video]++;
            }
        }

        vector<pair<string, int>> videos(videoCount.begin(), videoCount.end());
        sort(videos.begin(), videos.end(), [](const pair<string, int>& a, const pair<string, int>& b) {
            if (a.second == b.second) {
                return a.first < b.first;
            }
            return a.second < b.second;
        });

        vector<string> result;
        for (auto& video : videos) {
            result.push_back(video.first);
        }
        return result;
    }
};