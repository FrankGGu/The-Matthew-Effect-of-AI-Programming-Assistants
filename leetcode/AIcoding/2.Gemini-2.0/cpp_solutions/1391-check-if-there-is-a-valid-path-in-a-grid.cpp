#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool hasValidPath(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<bool>> visited(m, vector<bool>(n, false));
        queue<pair<int, int>> q;
        q.push({0, 0});
        visited[0][0] = true;

        while (!q.empty()) {
            int row = q.front().first;
            int col = q.front().second;
            q.pop();

            if (row == m - 1 && col == n - 1) {
                return true;
            }

            int street = grid[row][col];
            vector<pair<int, int>> next;

            if (street == 1) {
                next.push_back({row, col - 1});
                next.push_back({row, col + 1});
            } else if (street == 2) {
                next.push_back({row - 1, col});
                next.push_back({row + 1, col});
            } else if (street == 3) {
                next.push_back({row, col - 1});
                next.push_back({row + 1, col});
            } else if (street == 4) {
                next.push_back({row, col + 1});
                next.push_back({row + 1, col});
            } else if (street == 5) {
                next.push_back({row, col - 1});
                next.push_back({row - 1, col});
            } else {
                next.push_back({row, col + 1});
                next.push_back({row - 1, col});
            }

            for (auto& p : next) {
                int nextRow = p.first;
                int nextCol = p.second;

                if (nextRow >= 0 && nextRow < m && nextCol >= 0 && nextCol < n && !visited[nextRow][nextCol]) {
                    int nextStreet = grid[nextRow][nextCol];
                    bool valid = false;

                    if (street == 1) {
                        if (nextCol == col - 1 && (nextStreet == 1 || nextStreet == 4 || nextStreet == 6)) valid = true;
                        if (nextCol == col + 1 && (nextStreet == 1 || nextStreet == 3 || nextStreet == 5)) valid = true;
                    } else if (street == 2) {
                        if (nextRow == row - 1 && (nextStreet == 2 || nextStreet == 3 || nextStreet == 4)) valid = true;
                        if (nextRow == row + 1 && (nextStreet == 2 || nextStreet == 5 || nextStreet == 6)) valid = true;
                    } else if (street == 3) {
                        if (nextCol == col - 1 && (nextStreet == 1 || nextStreet == 4 || nextStreet == 6)) valid = true;
                        if (nextRow == row + 1 && (nextStreet == 2 || nextStreet == 5 || nextStreet == 6)) valid = true;
                    } else if (street == 4) {
                        if (nextCol == col + 1 && (nextStreet == 1 || nextStreet == 3 || nextStreet == 5)) valid = true;
                        if (nextRow == row + 1 && (nextStreet == 2 || nextStreet == 5 || nextStreet == 6)) valid = true;
                    } else if (street == 5) {
                        if (nextCol == col - 1 && (nextStreet == 1 || nextStreet == 4 || nextStreet == 6)) valid = true;
                        if (nextRow == row - 1 && (nextStreet == 2 || nextStreet == 3 || nextStreet == 4)) valid = true;
                    } else {
                        if (nextCol == col + 1 && (nextStreet == 1 || nextStreet == 3 || nextStreet == 5)) valid = true;
                        if (nextRow == row - 1 && (nextStreet == 2 || nextStreet == 3 || nextStreet == 4)) valid = true;
                    }

                    if (valid) {
                        q.push({nextRow, nextCol});
                        visited[nextRow][nextCol] = true;
                    }
                }
            }
        }

        return false;
    }
};