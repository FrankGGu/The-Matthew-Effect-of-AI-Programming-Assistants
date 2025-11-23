#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool isEscapePossible(vector<vector<int>>& blocked, vector<int>& start, vector<int>& target) {
        int rows = 1e5, cols = 1e5;
        unordered_set<int> blockSet;
        for (const auto& b : blocked) {
            blockSet.insert(b[0] * cols + b[1]);
        }

        auto bfs = [&](vector<int> s, vector<int> t) -> bool {
            queue<pair<int, int>> q;
            q.push({s[0], s[1]});
            unordered_set<int> visited;
            visited.insert(s[0] * cols + s[1]);

            int dir[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
            while (!q.empty()) {
                int size = q.size();
                for (int i = 0; i < size; ++i) {
                    auto [x, y] = q.front();
                    q.pop();

                    if (x == t[0] && y == t[1]) {
                        return true;
                    }

                    for (auto& d : dir) {
                        int nx = x + d[0];
                        int ny = y + d[1];
                        if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && 
                            blockSet.find(nx * cols + ny) == blockSet.end() && 
                            visited.find(nx * cols + ny) == visited.end()) {
                            visited.insert(nx * cols + ny);
                            q.push({nx, ny});
                        }
                    }
                }
            }
            return false;
        };

        return bfs(start, target) && bfs(target, start);
    }
};