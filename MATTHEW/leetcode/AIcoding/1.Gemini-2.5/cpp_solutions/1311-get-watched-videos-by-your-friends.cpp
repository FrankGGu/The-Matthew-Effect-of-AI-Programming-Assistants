#include <vector>
#include <string>
#include <queue>
#include <unordered_map>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::vector<std::string> getWatchedVideosByYourFriends(
        std::vector<std::vector<std::string>>& watchedVideos,
        std::vector<std::vector<int>>& friends,
        int id,
        int level) {

        int n = friends.size();
        std::vector<int> dist(n, -1);
        std::queue<int> q;

        q.push(id);
        dist[id] = 0;

        std::vector<int> level_friends;

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            if (dist[u] == level) {
                level_friends.push_back(u);
                continue;
            }
            if (dist[u] > level) {
                break;
            }

            for (int v : friends[u]) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.push(v);
                }
            }
        }

        // A slightly different BFS approach that might be clearer
        // Reset for the standard level-by-level BFS
        q = std::queue<int>();
        std::vector<bool> visited(n, false);

        q.push(id);
        visited[id] = true;

        int current_level = 0;
        while (!q.empty() && current_level < level) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int u = q.front();
                q.pop();
                for (int v : friends[u]) {
                    if (!visited[v]) {
                        visited[v] = true;
                        q.push(v);
                    }
                }
            }
            current_level++;
        }

        std::unordered_map<std::string, int> video_freq;
        while (!q.empty()) {
            int friend_id = q.front();
            q.pop();
            for (const std::string& video : watchedVideos[friend_id]) {
                video_freq[video]++;
            }
        }

        std::vector<std::pair<std::string, int>> sorted_videos;
        for (const auto& pair : video_freq) {
            sorted_videos.push_back(pair);
        }

        std::sort(sorted_videos.begin(), sorted_videos.end(), [](const std::pair<std::string, int>& a, const std::pair<std::string, int>& b) {
            if (a.second != b.second) {
                return a.second < b.second;
            }
            return a.first < b.first;
        });

        std::vector<std::string> result;
        result.reserve(sorted_videos.size());
        for (const auto& pair : sorted_videos) {
            result.push_back(pair.first);
        }

        return result;
    }
};