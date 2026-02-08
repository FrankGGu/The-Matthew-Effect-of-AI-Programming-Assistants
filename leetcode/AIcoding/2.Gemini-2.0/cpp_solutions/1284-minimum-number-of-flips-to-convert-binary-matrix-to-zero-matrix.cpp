#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minFlips(vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();
        int start = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                start = (start << 1) | mat[i][j];
            }
        }

        queue<pair<int, int>> q;
        unordered_set<int> visited;
        q.push({start, 0});
        visited.insert(start);

        while (!q.empty()) {
            int curr = q.front().first;
            int steps = q.front().second;
            q.pop();

            if (curr == 0) {
                return steps;
            }

            for (int i = 0; i < m; ++i) {
                for (int j = 0; j < n; ++j) {
                    int next = curr;
                    next ^= (1 << (i * n + j));
                    if (i > 0) next ^= (1 << ((i - 1) * n + j));
                    if (i < m - 1) next ^= (1 << ((i + 1) * n + j));
                    if (j > 0) next ^= (1 << (i * n + (j - 1)));
                    if (j < n - 1) next ^= (1 << (i * n + (j + 1)));

                    if (visited.find(next) == visited.end()) {
                        visited.insert(next);
                        q.push({next, steps + 1});
                    }
                }
            }
        }

        return -1;
    }
};