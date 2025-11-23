#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> gridIllumination(int n, vector<vector<int>>& lamps, vector<vector<int>>& queries) {
        unordered_map<int, int> row, col, diag1, diag2;
        unordered_set<long long> lampSet;

        for (auto& lamp : lamps) {
            int r = lamp[0], c = lamp[1];
            long long key = (long long)r * n + c;
            if (lampSet.count(key)) continue;
            lampSet.insert(key);
            row[r]++;
            col[c]++;
            diag1[r - c]++;
            diag2[r + c]++;
        }

        vector<int> res;
        for (auto& query : queries) {
            int r = query[0], c = query[1];
            if (row[r] > 0 || col[c] > 0 || diag1[r - c] > 0 || diag2[r + c] > 0) {
                res.push_back(1);
            } else {
                res.push_back(0);
            }

            for (int i = -1; i <= 1; i++) {
                for (int j = -1; j <= 1; j++) {
                    int nr = r + i, nc = c + j;
                    if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                        long long key = (long long)nr * n + nc;
                        if (lampSet.count(key)) {
                            lampSet.erase(key);
                            row[nr]--;
                            col[nc]--;
                            diag1[nr - nc]--;
                            diag2[nr + nc]--;
                            if (row[nr] == 0) row.erase(nr);
                            if (col[nc] == 0) col.erase(nc);
                            if (diag1[nr - nc] == 0) diag1.erase(nr - nc);
                            if (diag2[nr + nc] == 0) diag2.erase(nr + nc);
                        }
                    }
                }
            }
        }

        return res;
    }
};