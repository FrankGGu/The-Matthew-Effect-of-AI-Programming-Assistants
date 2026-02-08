#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int numWays(int n, vector<vector<int>>& relation, int k) {
        vector<vector<int>> adj(n);
        for (auto& r : relation) {
            adj[r[0]].push_back(r[1]);
        }

        queue<pair<int, int>> q;
        q.push({0, 0});
        int count = 0;

        while (!q.empty()) {
            int curr = q.front().first;
            int steps = q.front().second;
            q.pop();

            if (steps == k) {
                if (curr == n - 1) {
                    count++;
                }
                continue;
            }

            for (int neighbor : adj[curr]) {
                q.push({neighbor, steps + 1});
            }
        }

        return count;
    }
};