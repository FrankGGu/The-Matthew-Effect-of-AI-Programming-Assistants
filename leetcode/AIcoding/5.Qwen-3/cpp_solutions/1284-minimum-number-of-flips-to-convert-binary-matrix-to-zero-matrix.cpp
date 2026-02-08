#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minFlips(vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();
        int state = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                state |= mat[i][j] << (i * n + j);
            }
        }

        queue<int> q;
        q.push(state);
        vector<int> visited(1 << (m * n), 0);
        visited[state] = 1;

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int k = 0; k < size; ++k) {
                int current = q.front();
                q.pop();

                if (current == 0) return steps;

                for (int i = 0; i < m; ++i) {
                    for (int j = 0; j < n; ++j) {
                        int next = current;
                        for (int d = 0; d < 4; ++d) {
                            int ni = i + dirs[d][0];
                            int nj = j + dirs[d][1];
                            if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                                next ^= (1 << (ni * n + nj));
                            }
                        }
                        next ^= (1 << (i * n + j));

                        if (!visited[next]) {
                            visited[next] = 1;
                            q.push(next);
                        }
                    }
                }
            }
            ++steps;
        }

        return -1;
    }
};