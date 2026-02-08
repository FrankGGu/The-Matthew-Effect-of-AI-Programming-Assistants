class Solution {
public:
    vector<vector<int>> gridIllumination(int n, vector<vector<int>>& lamps, vector<vector<int>>& queries) {
        vector<vector<int>> result;
        vector<vector<int>> grid(n, vector<int>(n, 0));
        unordered_set<long long> lampSet;
        vector<int> rowCount(n, 0), colCount(n, 0), diagCount(2 * n, 0), antiDiagCount(2 * n, 0);

        for (const auto& lamp : lamps) {
            int x = lamp[0], y = lamp[1];
            if (grid[x][y] == 0) {
                lampSet.insert((long long)x * n + y);
                rowCount[x]++;
                colCount[y]++;
                diagCount[x - y + n]++;
                antiDiagCount[x + y]++;
            }
            grid[x][y] = 1;
        }

        for (const auto& query : queries) {
            int x = query[0], y = query[1];
            if (rowCount[x] > 0 || colCount[y] > 0 || diagCount[x - y + n] > 0 || antiDiagCount[x + y] > 0) {
                result.push_back({1});
            } else {
                result.push_back({0});
            }
            for (int i = -1; i <= 1; ++i) {
                for (int j = -1; j <= 1; ++j) {
                    if (i == 0 && j == 0) continue;
                    int nx = x + i, ny = y + j;
                    if (nx >= 0 && nx < n && ny >= 0 && ny < n) {
                        long long lampKey = (long long)nx * n + ny;
                        if (lampSet.count(lampKey)) {
                            lampSet.erase(lampKey);
                            rowCount[nx]--;
                            colCount[ny]--;
                            diagCount[nx - ny + n]--;
                            antiDiagCount[nx + ny]--;
                            grid[nx][ny] = 0;
                        }
                    }
                }
            }
        }

        return result;
    }
};