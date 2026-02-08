#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool canAliceWin(int n, int startAlice, int startBob, vector<vector<int>>& graph) {
        if (n == 1) return false;
        if (graph[startBob - 1].size() == 1) return true;

        vector<vector<int>> distA(n, vector<int>(n, -1));
        vector<vector<int>> distB(n, vector<int>(n, -1));

        for (int i = 0; i < n; ++i) {
            queue<int> q;
            vector<int> dist(n, -1);
            dist[i] = 0;
            q.push(i);

            while (!q.empty()) {
                int u = q.front();
                q.pop();

                for (int v : graph[u]) {
                    if (dist[v - 1] == -1) {
                        dist[v - 1] = dist[u] + 1;
                        q.push(v - 1);
                    }
                }
            }
            distA[i] = dist;

            dist.assign(n, -1);
            dist[i] = 0;
            q.push(i);

            while (!q.empty()) {
                int u = q.front();
                q.pop();

                for (int v : graph[u]) {
                    if (dist[v - 1] == -1) {
                        dist[v - 1] = dist[u] + 1;
                        q.push(v - 1);
                    }
                }
            }
            distB[i] = dist;
        }

        vector<vector<bool>> visited(n, vector<bool>(n, false));
        queue<pair<int, int>> q;
        q.push({startAlice - 1, startBob - 1});
        visited[startAlice - 1][startBob - 1] = true;

        for (int i = 0; i < 50 * n * n; ++i) {
            int size = q.size();
            for (int k = 0; k < size; ++k) {
                int a = q.front().first;
                int b = q.front().second;
                q.pop();

                if (a == b) continue;

                for (int nb : graph[b]) {
                    int bestNa = -1;
                    for (int na : graph[a]) {
                        if (distA[na - 1][nb - 1] <= 2 && distB[nb - 1][nb - 1] > 0) {
                            bestNa = -2;
                            break;
                        }
                        if (bestNa == -1 || distA[na - 1][nb - 1] < distA[bestNa - 1][nb - 1]) {
                            bestNa = na;
                        }
                    }
                    if (bestNa == -2) continue;

                    if (bestNa == -1) bestNa = a + 1;

                    if (!visited[bestNa - 1][nb - 1]) {
                        visited[bestNa - 1][nb - 1] = true;
                        q.push({bestNa - 1, nb - 1});
                    }
                }
            }
            if (q.empty()) return true;
        }

        return false;
    }
};