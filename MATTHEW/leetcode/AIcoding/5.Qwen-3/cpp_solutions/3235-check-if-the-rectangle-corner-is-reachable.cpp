#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool isReachable(int X, int Y) {
        vector<vector<int>> dirs = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        queue<pair<int, int>> q;
        unordered_set<string> visited;

        q.push({0, 0});
        visited.insert("0,0");

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();

            if (x == X && y == Y) {
                return true;
            }

            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && ny >= 0 && visited.find(to_string(nx) + "," + to_string(ny)) == visited.end()) {
                    visited.insert(to_string(nx) + "," + to_string(ny));
                    q.push({nx, ny});
                }
            }
        }

        return false;
    }
};