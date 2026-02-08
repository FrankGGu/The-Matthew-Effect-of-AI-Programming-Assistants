#include <vector>
#include <queue>
#include <utility>

class Solution {
public:
    bool canCross(int k, int R, int C, const std::vector<std::vector<int>>& cells) {
        std::vector<std::vector<bool>> is_water(R, std::vector<bool>(C, false));

        for (int i = 0; i < k; ++i) {
            is_water[cells[i][0] - 1][cells[i][1] - 1] = true;
        }

        std::queue<std::pair<int, int>> q;
        std::vector<std::vector<bool>> visited(R, std::vector<bool>(C, false));

        for (int j = 0; j < C; ++j) {
            if (!is_water[0][j]) {
                q.push({0, j});
                visited[0][j] = true;
            }
        }

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q.empty()) {
            std::pair<int, int> curr = q.front();
            q.pop();
            int r = curr.first;
            int c = curr.second;

            if (r == R - 1) {
                return true;
            }

            for (int i = 0; i < 4; ++i) {
                int next_r = r + dr[i];
                int next_c = c + dc[i];

                if (next_r >= 0 && next_r < R && next_c >= 0 && next_c < C &&
                    !is_water[next_r][next_c] && !visited[next_r][next_c]) {
                    visited[next_r][next_c] = true;
                    q.push({next_r, next_c});
                }
            }
        }

        return false;
    }

    int latestDayToCross(int row, int col, std::vector<std::vector<int>>& cells) {
        int low = 1;
        int high = cells.size();
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canCross(mid, row, col, cells)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }
};