class Solution {
public:
    bool isEscapePossible(vector<vector<int>>& blocked, vector<int>& source, vector<int>& target) {
        unordered_set<long long> blocked_set;
        for (const auto& b : blocked) {
            blocked_set.insert((long long)b[0] * 1000000 + b[1]);
        }

        return bfs(source, target, blocked_set) && bfs(target, source, blocked_set);
    }

private:
    bool bfs(vector<int> start, vector<int> target, unordered_set<long long>& blocked_set) {
        unordered_set<long long> visited;
        queue<vector<int>> q;
        q.push(start);
        visited.insert((long long)start[0] * 1000000 + start[1]);

        int dirs[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto curr = q.front();
                q.pop();
                if (curr[0] == target[0] && curr[1] == target[1]) {
                    return true;
                }
                for (const auto& dir : dirs) {
                    int x = curr[0] + dir[0];
                    int y = curr[1] + dir[1];
                    if (x < 0 || x >= 1000000 || y < 0 || y >= 1000000) {
                        continue;
                    }
                    long long key = (long long)x * 1000000 + y;
                    if (blocked_set.count(key) || visited.count(key)) {
                        continue;
                    }
                    visited.insert(key);
                    q.push({x, y});
                }
            }
            steps++;
            if (steps > 200) {
                break;
            }
        }
        return visited.size() > 200;
    }
};