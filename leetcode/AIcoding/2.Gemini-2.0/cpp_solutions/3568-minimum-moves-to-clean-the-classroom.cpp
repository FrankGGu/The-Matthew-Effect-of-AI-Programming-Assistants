#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

int minimumMoves(vector<vector<int>>& classroom) {
    int n = classroom.size();
    int m = classroom[0].size();

    int start_x = -1, start_y = -1;
    int end_x = -1, end_y = -1;
    vector<pair<int, int>> obstacles;

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            if (classroom[i][j] == 1) {
                start_x = i;
                start_y = j;
            } else if (classroom[i][j] == 2) {
                end_x = i;
                end_y = j;
            } else if (classroom[i][j] == 3) {
                obstacles.push_back({i, j});
            }
        }
    }

    int min_moves = -1;

    function<void(int, int, int, vector<vector<bool>>)> solve = 
        [&](int x, int y, int moves, vector<vector<bool>> visited) {
        if (x == end_x && y == end_y) {
            if (min_moves == -1 || moves < min_moves) {
                min_moves = moves;
            }
            return;
        }

        if (min_moves != -1 && moves >= min_moves) {
            return;
        }

        if (x < 0 || x >= n || y < 0 || y >= m || visited[x][y]) {
            return;
        }

        visited[x][y] = true;

        bool is_obstacle = false;
        for (auto& obs : obstacles) {
            if (obs.first == x && obs.second == y) {
                is_obstacle = true;
                break;
            }
        }

        if (is_obstacle) return;

        solve(x + 1, y, moves + 1, visited);
        solve(x - 1, y, moves + 1, visited);
        solve(x, y + 1, moves + 1, visited);
        solve(x, y - 1, moves + 1, visited);
    };

    vector<vector<bool>> visited(n, vector<bool>(m, false));
    solve(start_x, start_y, 0, visited);

    return min_moves;
}