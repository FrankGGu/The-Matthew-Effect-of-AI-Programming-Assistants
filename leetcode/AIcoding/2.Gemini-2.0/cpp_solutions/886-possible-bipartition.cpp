#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool possibleBipartition(int n, vector<vector<int>>& dislikes) {
        vector<vector<int>> adj(n + 1);
        for (auto& dislike : dislikes) {
            adj[dislike[0]].push_back(dislike[1]);
            adj[dislike[1]].push_back(dislike[0]);
        }

        vector<int> color(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            if (color[i] == 0) {
                queue<int> q;
                q.push(i);
                color[i] = 1;

                while (!q.empty()) {
                    int u = q.front();
                    q.pop();

                    for (int v : adj[u]) {
                        if (color[v] == 0) {
                            color[v] = -color[u];
                            q.push(v);
                        } else if (color[v] == color[u]) {
                            return false;
                        }
                    }
                }
            }
        }

        return true;
    }
};