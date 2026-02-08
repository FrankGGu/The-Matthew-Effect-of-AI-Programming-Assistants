class Solution {
public:
    int snakesAndLadders(vector<vector<int>>& board) {
        int n = board.size();
        vector<int> flatBoard(n * n + 1);
        int idx = 1;
        bool leftToRight = true;
        for (int i = n - 1; i >= 0; --i) {
            if (leftToRight) {
                for (int j = 0; j < n; ++j) {
                    flatBoard[idx++] = board[i][j];
                }
            } else {
                for (int j = n - 1; j >= 0; --j) {
                    flatBoard[idx++] = board[i][j];
                }
            }
            leftToRight = !leftToRight;
        }

        queue<int> q;
        vector<int> dist(n * n + 1, -1);
        q.push(1);
        dist[1] = 0;

        while (!q.empty()) {
            int curr = q.front();
            q.pop();

            if (curr == n * n) {
                return dist[curr];
            }

            for (int next = curr + 1; next <= min(curr + 6, n * n); ++next) {
                int dest = flatBoard[next] == -1 ? next : flatBoard[next];
                if (dist[dest] == -1) {
                    dist[dest] = dist[curr] + 1;
                    q.push(dest);
                }
            }
        }

        return -1;
    }
};