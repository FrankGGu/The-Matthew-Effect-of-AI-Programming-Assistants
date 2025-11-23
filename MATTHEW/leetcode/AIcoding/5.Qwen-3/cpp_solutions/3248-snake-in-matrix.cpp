#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int snakesAndLadders(vector<vector<int>>& board) {
        int n = board.size();
        vector<vector<int>> visited(n, vector<int>(n, 0));
        queue<pair<int, int>> q;
        q.push({0, 1});
        visited[0][0] = 1;

        while (!q.empty()) {
            auto [row, col] = q.front();
            q.pop();
            int current = row * n + col + 1;

            if (current == n * n) return visited[row][col] - 1;

            for (int i = 1; i <= 6; ++i) {
                int next = current + i;
                int r = (next - 1) / n;
                int c = (next - 1) % n;

                if (r % 2 == 1) c = n - 1 - c;

                if (r >= n || c >= n || visited[r][c]) continue;

                visited[r][c] = visited[row][col] + 1;
                q.push({r, c});

                if (board[r][c] != -1) {
                    int next_r = (board[r][c] - 1) / n;
                    int next_c = (board[r][c] - 1) % n;
                    if (next_r % 2 == 1) next_c = n - 1 - next_c;
                    if (!visited[next_r][next_c]) {
                        visited[next_r][next_c] = visited[r][c];
                        q.push({next_r, next_c});
                    }
                }
            }
        }

        return -1;
    }
};