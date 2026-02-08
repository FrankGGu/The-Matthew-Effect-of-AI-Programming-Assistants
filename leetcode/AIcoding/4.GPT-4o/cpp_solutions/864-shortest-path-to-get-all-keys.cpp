#include <vector>
#include <queue>
#include <string>
#include <unordered_set>
#include <utility>

using namespace std;

class Solution {
public:
    int shortestPathAllKeys(vector<string>& grid) {
        int m = grid.size(), n = grid[0].size(), totalKeys = 0, startX, startY;
        vector<vector<bool>> visited(m, vector<bool>(n, false));

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == '@') {
                    startX = i;
                    startY = j;
                }
                if (islower(grid[i][j])) totalKeys++;
            }
        }

        int targetMask = (1 << totalKeys) - 1;
        queue<tuple<int, int, int, int>> q;
        q.emplace(startX, startY, 0, 0);
        visited[startX][startY] = true;

        vector<int> directions = {-1, 0, 1, 0, -1};

        while (!q.empty()) {
            auto [x, y, keys, steps] = q.front();
            q.pop();

            if (keys == targetMask) return steps;

            for (int d = 0; d < 4; d++) {
                int newX = x + directions[d];
                int newY = y + directions[d + 1];

                if (newX < 0 || newX >= m || newY < 0 || newY >= n || visited[newX][newY]) continue;

                char cell = grid[newX][newY];
                if (cell == '#') continue;

                if (islower(cell)) {
                    int keyIndex = cell - 'a';
                    keys |= (1 << keyIndex);
                } else if (isupper(cell) && !(keys & (1 << (cell - 'A')))) {
                    continue;
                }

                visited[newX][newY] = true;
                q.emplace(newX, newY, keys, steps + 1);
            }
        }
        return -1;
    }
};