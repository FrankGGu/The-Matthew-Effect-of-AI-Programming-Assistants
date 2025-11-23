#include <vector>
#include <queue>
#include <climits>

using namespace std;

int findCheapestPrice(int n, vector<vector<int>>& flights, int src, int dst, int k) {
    vector<vector<pair<int, int>>> adj(n);
    for (auto& flight : flights) {
        adj[flight[0]].push_back({flight[1], flight[2]});
    }

    vector<int> dist(n, INT_MAX);
    dist[src] = 0;

    queue<pair<int, int>> q;
    q.push({src, 0});

    int stops = 0;
    while (!q.empty() && stops <= k) {
        int size = q.size();
        for (int i = 0; i < size; ++i) {
            int u = q.front().first;
            int price = q.front().second;
            q.pop();

            for (auto& edge : adj[u]) {
                int v = edge.first;
                int w = edge.second;

                if (price + w < dist[v]) {
                    dist[v] = price + w;
                    q.push({v, dist[v]});
                }
            }
        }
        stops++;
    }

    return (dist[dst] == INT_MAX) ? -1 : dist[dst];
}