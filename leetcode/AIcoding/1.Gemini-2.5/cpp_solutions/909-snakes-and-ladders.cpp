#include <vector>
#include <queue>
#include <algorithm>

class Solution {
public:
    int snakesAndLadders(std::vector<std::vector<int>>& board) {
        int n = board.size();
        int total_squares = n * n;

        std::vector<int> dist(total_squares + 1, -1);
        std::queue<int> q;

        dist[1] = 0;
        q.push(1);

        while (!q.empty()) {
            int curr_square = q.front();
            q.pop();

            if (curr_square == total_squares) {
                return dist[curr_square];
            }

            for (int roll = 1; roll <= 6; ++roll) {
                int next_square = curr_square + roll;

                if (next_square > total_squares) {
                    continue;
                }

                int r_from_bottom = (next_square - 1) / n;
                int r = (n - 1) - r_from_bottom;

                int c;
                if (r_from_bottom % 2 == 0) {
                    c = (next_square - 1) % n;
                } else {
                    c = (n - 1) - ((next_square - 1) % n);
                }

                int final_dest_square;
                if (board[r][c] != -1) {
                    final_dest_square = board[r][c];
                } else {
                    final_dest_square = next_square;
                }

                if (dist[final_dest_square] == -1) {
                    dist[final_dest_square] = dist[curr_square] + 1;
                    q.push(final_dest_square);
                }
            }
        }

        return -1;
    }
};