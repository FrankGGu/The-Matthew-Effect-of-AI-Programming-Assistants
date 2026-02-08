#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> zigzagGridTraversalWithSkip(int n, int k) {
        vector<int> result;
        queue<pair<int, int>> q;
        q.push({0, 0});
        vector<vector<bool>> visited(n, vector<bool>(n, false));
        visited[0][0] = true;
        int dir = 0;         int steps = 0;
        int count = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [x, y] = q.front();
                q.pop();
                result.push_back(x * n + y);
                count++;
                if (count == k) {
                    return result;
                }
                if (dir % 2 == 0) {
                    if (y + 1 < n && !visited[x][y + 1]) {
                        q.push({x, y + 1});
                        visited[x][y + 1] = true;
                    }
                    if (x + 1 < n && !visited[x + 1][y]) {
                        q.push({x + 1, y});
                        visited[x + 1][y] = true;
                    }
                } else {
                    if (y - 1 >= 0 && !visited[x][y - 1]) {
                        q.push({x, y - 1});
                        visited[x][y - 1] = true;
                    }
                    if (x - 1 >= 0 && !visited[x - 1][y]) {
                        q.push({x - 1, y});
                        visited[x - 1][y] = true;
                    }
                }
            }
            dir++;
        }
        return result;
    }
};