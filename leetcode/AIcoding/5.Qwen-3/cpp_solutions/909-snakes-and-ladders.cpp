#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int snakesAndLadders(vector<vector<int>>& board) {
        int n = board.size();
        int target = n * n;
        vector<bool> visited(n * n + 1, false);
        queue<pair<int, int>> q;
        q.push({1, 0});
        visited[1] = true;

        while (!q.empty()) {
            auto [current, steps] = q.front();
            q.pop();

            if (current == target) {
                return steps;
            }

            for (int i = 1; i <= 6; ++i) {
                int next = current + i;
                if (next > target) break;

                int row = n - 1 - (next - 1) / n;
                int col = (next - 1) % n;
                if ((n - 1 - (next - 1) / n) % 2 == 1) {
                    col = n - 1 - col;
                }

                if (board[row][col] != -1) {
                    next = board[row][col];
                }

                if (!visited[next]) {
                    visited[next] = true;
                    q.push({next, steps + 1});
                }
            }
        }

        return -1;
    }
};