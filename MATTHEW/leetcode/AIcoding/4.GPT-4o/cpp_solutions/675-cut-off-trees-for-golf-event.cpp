#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int cutOffTree(vector<vector<int>>& forest) {
        if (forest.empty() || forest[0].empty()) return -1;

        int rows = forest.size(), cols = forest[0].size();
        vector<pair<int, pair<int, int>>> trees;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (forest[i][j] > 1) {
                    trees.push_back({forest[i][j], {i, j}});
                }
            }
        }

        sort(trees.begin(), trees.end());

        int totalSteps = 0;
        pair<int, int> start = {0, 0};

        for (auto& tree : trees) {
            int steps = bfs(forest, start, tree.second);
            if (steps == -1) return -1;
            totalSteps += steps;
            start = tree.second;
        }

        return totalSteps;
    }

private:
    int bfs(vector<vector<int>>& forest, pair<int, int> start, pair<int, int> target) {
        int rows = forest.size(), cols = forest[0].size();
        vector<vector<bool>> visited(rows, vector<bool>(cols, false));
        queue<pair<int, int>> q;
        q.push(start);
        visited[start.first][start.second] = true;
        int steps = 0;

        vector<vector<int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [x, y] = q.front();
                q.pop();

                if (x == target.first && y == target.second) {
                    return steps;
                }

                for (auto& dir : directions) {
                    int newX = x + dir[0];
                    int newY = y + dir[1];

                    if (newX >= 0 && newX < rows && newY >= 0 && newY < cols &&
                        forest[newX][newY] != 0 && !visited[newX][newY]) {
                        visited[newX][newY] = true;
                        q.push({newX, newY});
                    }
                }
            }
            ++steps;
        }

        return -1;
    }
};