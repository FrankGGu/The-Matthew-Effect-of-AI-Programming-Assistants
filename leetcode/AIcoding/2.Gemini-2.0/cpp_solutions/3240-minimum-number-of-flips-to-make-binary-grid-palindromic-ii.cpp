#include <vector>
#include <queue>
#include <map>

using namespace std;

class Solution {
public:
    int minFlips(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        int k = m * n;

        if (k % 2 != 0) return -1;

        int start = 0;
        for (int i = 0; i < k / 2; ++i) {
            start |= (grid[i / n][i % n] << i);
        }

        int target = 0;

        queue<int> q;
        map<int, int> dist;

        q.push(start);
        dist[start] = 0;

        while (!q.empty()) {
            int curr = q.front();
            q.pop();

            if (curr == target) {
                return dist[curr];
            }

            for (int i = 0; i < k / 2; ++i) {
                int next = curr ^ (1 << i);
                int r1 = i / n;
                int c1 = i % n;
                int r2 = m - 1 - r1;
                int c2 = n - 1 - c1;
                int j = r2 * n + c2;
                next ^= (1 << j);

                if (dist.find(next) == dist.end()) {
                    dist[next] = dist[curr] + 1;
                    q.push(next);
                }
            }
        }

        return -1;
    }
};