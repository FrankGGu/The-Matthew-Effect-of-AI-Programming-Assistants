#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> gridIllumination(int n, vector<vector<int>>& lamps, vector<vector<int>>& queries) {
        unordered_map<int, int> row, col, diag1, diag2;
        unordered_set<long long> lampSet;

        for (const auto& lamp : lamps) {
            int x = lamp[0];
            int y = lamp[1];
            long long key = (long long)x * n + y;
            if (lampSet.count(key)) continue;
            lampSet.insert(key);
            row[x]++;
            col[y]++;
            diag1[x - y]++;
            diag2[x + y]++;
        }

        vector<int> res;
        for (const auto& query : queries) {
            int x = query[0];
            int y = query[1];

            if (row[x] > 0 || col[y] > 0 || diag1[x - y] > 0 || diag2[x + y] > 0) {
                res.push_back(1);
            } else {
                res.push_back(0);
            }

            for (int i = -1; i <= 1; ++i) {
                for (int j = -1; j <= 1; ++j) {
                    int nx = x + i;
                    int ny = y + j;
                    if (nx >= 0 && nx < n && ny >= 0 && ny < n) {
                        long long key = (long long)nx * n + ny;
                        if (lampSet.count(key)) {
                            lampSet.erase(key);
                            row[nx]--;
                            col[ny]--;
                            diag1[nx - ny]--;
                            diag2[nx + ny]--;
                        }
                    }
                }
            }
        }

        return res;
    }
};