#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int snakesAndLadders(vector<vector<int>>& board) {
        int n = board.size();
        vector<int> flatBoard(n * n, -1);
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int idx = (n - i - 1) * n + (j % 2 == 0 ? j : n - j - 1);
                flatBoard[idx] = board[i][j];
            }
        }

        queue<int> q;
        q.push(0);
        unordered_set<int> visited;
        visited.insert(0);
        int moves = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int curr = q.front();
                q.pop();
                if (curr == n * n - 1) return moves;

                for (int j = 1; j <= 6; ++j) {
                    int next = curr + j;
                    if (next < n * n) {
                        if (flatBoard[next] != -1) {
                            next = flatBoard[next] - 1;
                        }
                        if (visited.find(next) == visited.end()) {
                            visited.insert(next);
                            q.push(next);
                        }
                    }
                }
            }
            ++moves;
        }
        return -1;
    }
};