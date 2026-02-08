#include <queue>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int digitOperations(int x, int y) {
        if (x == y) {
            return 0;
        }

        std::unordered_map<int, int> dist_x = bfs(x);
        std::unordered_map<int, int> dist_y = bfs(y);

        int min_ops = -1;

        const auto& map1 = (dist_x.size() < dist_y.size()) ? dist_x : dist_y;
        const auto& map2 = (dist_x.size() < dist_y.size()) ? dist_y : dist_x;

        for (const auto& pair1 : map1) {
            int common_val = pair1.first;
            if (map2.count(common_val)) {
                int total_ops = pair1.second + map2.at(common_val);
                if (min_ops == -1 || total_ops < min_ops) {
                    min_ops = total_ops;
                }
            }
        }

        return min_ops;
    }

private:
    std::unordered_map<int, int> bfs(int start_node) {
        std::unordered_map<int, int> dist;
        std::queue<std::pair<int, int>> q;

        dist[start_node] = 0;
        q.push({start_node, 0});

        while (!q.empty()) {
            auto [current_node, current_dist] = q.front();
            q.pop();

            int next_node_del = current_node / 10;
            if (dist.find(next_node_del) == dist.end()) {
                dist[next_node_del] = current_dist + 1;
                q.push({next_node_del, current_dist + 1});
            }

            int prefix = current_node / 10;
            for (int i = 0; i <= 9; ++i) {
                int next_node_rep = prefix * 10 + i;
                if (dist.find(next_node_rep) == dist.end()) {
                    dist[next_node_rep] = current_dist + 1;
                    q.push({next_node_rep, current_dist + 1});
                }
            }
        }
        return dist;
    }
};