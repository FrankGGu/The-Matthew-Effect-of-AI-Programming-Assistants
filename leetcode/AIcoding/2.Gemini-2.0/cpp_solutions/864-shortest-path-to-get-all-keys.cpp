#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

struct State {
    int row;
    int col;
    int keys;
    int steps;
};

int shortestPathAllKeys(vector<string>& grid) {
    int rows = grid.size();
    int cols = grid[0].size();
    int startRow = -1, startCol = -1;
    int maxKeys = 0;

    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            if (grid[i][j] == '@') {
                startRow = i;
                startCol = j;
            } else if (islower(grid[i][j])) {
                maxKeys = max(maxKeys, grid[i][j] - 'a' + 1);
            }
        }
    }

    int allKeysMask = (1 << maxKeys) - 1;

    queue<State> q;
    q.push({startRow, startCol, 0, 0});

    unordered_set<int> visited;
    int startHash = (startRow * cols + startCol) * (1 << 6) + 0;
    visited.insert(startHash);

    int dr[] = {0, 0, 1, -1};
    int dc[] = {1, -1, 0, 0};

    while (!q.empty()) {
        State curr = q.front();
        q.pop();

        if (curr.keys == allKeysMask) {
            return curr.steps;
        }

        for (int i = 0; i < 4; ++i) {
            int newRow = curr.row + dr[i];
            int newCol = curr.col + dc[i];

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] != '#') {
                char cell = grid[newRow][newCol];
                int newKeys = curr.keys;

                if (islower(cell)) {
                    newKeys |= (1 << (cell - 'a'));
                } else if (isupper(cell)) {
                    if ((curr.keys & (1 << (cell - 'A'))) == 0) {
                        continue;
                    }
                }

                int newHash = (newRow * cols + newCol) * (1 << 6) + newKeys;
                if (visited.find(newHash) == visited.end()) {
                    visited.insert(newHash);
                    q.push({newRow, newCol, newKeys, curr.steps + 1});
                }
            }
        }
    }

    return -1;
}