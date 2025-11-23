class Solution {
public:
    int minPushBox(vector<vector<char>>& grid, vector<int>& start, vector<int>& target) {
        int m = grid.size(), n = grid[0].size();
        queue<tuple<int, int, int>> q;
        unordered_set<string> visited;
        int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

        auto isValid = [&](int x, int y) {
            return x >= 0 && x < m && y >= 0 && y < n && grid[x][y] != '#';
        };

        q.push({start[0], start[1], 0});
        visited.insert(to_string(start[0]) + "," + to_string(start[1]) + "," + to_string(start[0]) + "," + to_string(start[1]));

        while (!q.empty()) {
            auto [bx, by, pushCount] = q.front(); q.pop();
            if (bx == target[0] && by == target[1]) return pushCount;

            for (auto& [dx, dy] : directions) {
                int nbx = bx + dx, nby = by + dy;
                if (!isValid(nbx, nby)) continue;

                if (visited.count(to_string(nbx) + "," + to_string(nby) + "," + to_string(bx) + "," + to_string(by))) continue;

                bool canMove = false;
                for (auto& [ddx, ddy] : directions) {
                    int prevX = bx - ddx, prevY = by - ddy;
                    if (isValid(prevX, prevY) && (prevX != nbx || prevY != nby)) canMove = true;
                }

                if (canMove) {
                    visited.insert(to_string(nbx) + "," + to_string(nby) + "," + to_string(bx) + "," + to_string(by));
                    q.push({nbx, nby, pushCount + 1});
                }
            }
        }
        return -1;
    }
};