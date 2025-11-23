#include <iostream>
#include <vector>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    int maximumBombs(vector<vector<int>>& bombs) {
        int n = bombs.size();
        int maxCount = 0;

        for (int i = 0; i < n; ++i) {
            vector<bool> visited(n, false);
            queue<int> q;
            q.push(i);
            visited[i] = true;
            int count = 0;

            while (!q.empty()) {
                int current = q.front();
                q.pop();
                ++count;

                for (int j = 0; j < n; ++j) {
                    if (!visited[j]) {
                        int x1 = bombs[current][0];
                        int y1 = bombs[current][1];
                        int r1 = bombs[current][2];
                        int x2 = bombs[j][0];
                        int y2 = bombs[j][1];

                        if ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) <= r1 * r1) {
                            visited[j] = true;
                            q.push(j);
                        }
                    }
                }
            }

            maxCount = max(maxCount, count);
        }

        return maxCount;
    }
};