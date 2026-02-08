#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int snakesAndLadders(vector<vector<int>>& board) {
        int n = board.size();
        vector<int> arr(n * n + 1);
        int index = 1;
        bool leftToRight = true;
        for (int i = n - 1; i >= 0; --i) {
            if (leftToRight) {
                for (int j = 0; j < n; ++j) {
                    arr[index++] = board[i][j];
                }
            } else {
                for (int j = n - 1; j >= 0; --j) {
                    arr[index++] = board[i][j];
                }
            }
            leftToRight = !leftToRight;
        }

        vector<int> dist(n * n + 1, -1);
        queue<int> q;
        dist[1] = 0;
        q.push(1);

        while (!q.empty()) {
            int curr = q.front();
            q.pop();

            for (int next = curr + 1; next <= min(curr + 6, n * n); ++next) {
                int dest = (arr[next] == -1) ? next : arr[next];
                if (dist[dest] == -1) {
                    dist[dest] = dist[curr] + 1;
                    q.push(dest);
                }
            }
        }

        return dist[n * n];
    }
};