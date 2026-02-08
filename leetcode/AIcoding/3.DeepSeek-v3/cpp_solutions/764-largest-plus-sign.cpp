class Solution {
public:
    int orderOfLargestPlusSign(int N, vector<vector<int>>& mines) {
        vector<vector<int>> grid(N, vector<int>(N, 1));
        for (auto& mine : mines) {
            grid[mine[0]][mine[1]] = 0;
        }

        vector<vector<int>> left(N, vector<int>(N, 0));
        vector<vector<int>> right(N, vector<int>(N, 0));
        vector<vector<int>> up(N, vector<int>(N, 0));
        vector<vector<int>> down(N, vector<int>(N, 0));

        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                if (grid[i][j] == 1) {
                    left[i][j] = (j == 0) ? 1 : left[i][j-1] + 1;
                    up[i][j] = (i == 0) ? 1 : up[i-1][j] + 1;
                }
            }
        }

        for (int i = N-1; i >= 0; --i) {
            for (int j = N-1; j >= 0; --j) {
                if (grid[i][j] == 1) {
                    right[i][j] = (j == N-1) ? 1 : right[i][j+1] + 1;
                    down[i][j] = (i == N-1) ? 1 : down[i+1][j] + 1;
                }
            }
        }

        int res = 0;
        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                if (grid[i][j] == 1) {
                    int minLen = min(min(left[i][j], right[i][j]), min(up[i][j], down[i][j]));
                    res = max(res, minLen);
                }
            }
        }

        return res;
    }
};