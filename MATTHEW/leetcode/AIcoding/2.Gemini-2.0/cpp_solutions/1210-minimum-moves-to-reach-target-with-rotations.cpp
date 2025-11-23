#include <vector>
#include <queue>

using namespace std;

struct State {
    int row;
    int col;
    int dir;
    int moves;
};

int minimumMoves(vector<vector<int>>& grid) {
    int n = grid.size();
    if (grid[n - 1][n - 1] == 1 || grid[n - 1][n - 2] == 1) return -1;

    vector<vector<vector<bool>>> visited(n, vector<vector<bool>>(n, vector<bool>(2, false)));
    queue<State> q;
    q.push({0, 0, 0, 0});
    visited[0][0][0] = true;

    while (!q.empty()) {
        State curr = q.front();
        q.pop();

        if (curr.row == n - 1 && curr.col == n - 2 && curr.dir == 0) {
            return curr.moves;
        }

        // Move forward
        if (curr.dir == 0) {
            if (curr.col + 2 < n && grid[curr.row][curr.col + 2] == 0 && !visited[curr.row][curr.col + 1][0]) {
                q.push({curr.row, curr.col + 1, 0, curr.moves + 1});
                visited[curr.row][curr.col + 1][0] = true;
            }
        } else {
            if (curr.row + 2 < n && grid[curr.row + 2][curr.col] == 0 && !visited[curr.row + 1][curr.col][1]) {
                q.push({curr.row + 1, curr.col, 1, curr.moves + 1});
                visited[curr.row + 1][curr.col][1] = true;
            }
        }

        // Rotate clockwise
        if (curr.dir == 0) {
            if (curr.row + 1 < n && grid[curr.row + 1][curr.col] == 0 && grid[curr.row + 1][curr.col + 1] == 0 && !visited[curr.row][curr.col][1]) {
                q.push({curr.row, curr.col, 1, curr.moves + 1});
                visited[curr.row][curr.col][1] = true;
            }
        } else {
            if (curr.col + 1 < n && grid[curr.row][curr.col + 1] == 0 && grid[curr.row + 1][curr.col + 1] == 0 && !visited[curr.row][curr.col][0]) {
                q.push({curr.row, curr.col, 0, curr.moves + 1});
                visited[curr.row][curr.col][0] = true;
            }
        }

        // Move down/right
        if (curr.dir == 0) {
            if (curr.row + 1 < n && grid[curr.row + 1][curr.col] == 0 && grid[curr.row + 1][curr.col + 1] == 0 && !visited[curr.row + 1][curr.col][0]) {
                q.push({curr.row + 1, curr.col, 0, curr.moves + 1});
                visited[curr.row + 1][curr.col][0] = true;
            }
        } else {
            if (curr.col + 1 < n && grid[curr.row][curr.col + 1] == 0 && grid[curr.row + 1][curr.col + 1] == 0 && !visited[curr.row][curr.col + 1][1]) {
                q.push({curr.row, curr.col + 1, 1, curr.moves + 1});
                visited[curr.row][curr.col + 1][1] = true;
            }
        }
    }

    return -1;
}