#include <vector>
#include <unordered_set>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countCombinations(vector<string>& pieces, vector<vector<int>>& positions) {
        vector<vector<pair<int, int>>> directions;
        for (auto& piece : pieces) {
            if (piece == "rook") {
                directions.push_back({{0, 1}, {1, 0}, {0, -1}, {-1, 0}});
            } else if (piece == "bishop") {
                directions.push_back({{1, 1}, {1, -1}, {-1, 1}, {-1, -1}});
            } else if (piece == "queen") {
                directions.push_back({{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}});
            }
        }

        int n = pieces.size();
        vector<vector<pair<int, int>>> paths(n);
        for (int i = 0; i < n; ++i) {
            int x = positions[i][0] - 1;
            int y = positions[i][1] - 1;
            for (auto& dir : directions[i]) {
                int dx = dir.first;
                int dy = dir.second;
                for (int step = 1; step <= 7; ++step) {
                    int nx = x + dx * step;
                    int ny = y + dy * step;
                    if (nx < 0 || nx >= 8 || ny < 0 || ny >= 8) break;
                    paths[i].emplace_back(nx, ny);
                }
            }
            paths[i].emplace_back(x, y);
        }

        int res = 0;
        vector<pair<int, int>> current(n);
        backtrack(0, n, paths, current, res);
        return res;
    }

private:
    void backtrack(int idx, int n, vector<vector<pair<int, int>>>& paths, vector<pair<int, int>>& current, int& res) {
        if (idx == n) {
            if (isValid(current)) {
                ++res;
            }
            return;
        }

        for (auto& pos : paths[idx]) {
            current[idx] = pos;
            backtrack(idx + 1, n, paths, current, res);
        }
    }

    bool isValid(vector<pair<int, int>>& positions) {
        for (int i = 0; i < positions.size(); ++i) {
            for (int j = i + 1; j < positions.size(); ++j) {
                if (positions[i] == positions[j]) {
                    return false;
                }
            }
        }
        return true;
    }
};