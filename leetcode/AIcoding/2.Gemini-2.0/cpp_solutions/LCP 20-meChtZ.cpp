#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

int numBusesToDestination(vector<vector<int>>& routes, int source, int target) {
    if (source == target) return 0;

    int n = routes.size();
    vector<vector<int>> adj(n);
    for (int i = 0; i < n; ++i) {
        for (int j = i + 1; j < n; ++j) {
            bool intersect = false;
            for (int stop : routes[i]) {
                for (int otherStop : routes[j]) {
                    if (stop == otherStop) {
                        intersect = true;
                        break;
                    }
                }
                if (intersect) break;
            }
            if (intersect) {
                adj[i].push_back(j);
                adj[j].push_back(i);
            }
        }
    }

    vector<int> startBuses;
    for (int i = 0; i < n; ++i) {
        for (int stop : routes[i]) {
            if (stop == source) {
                startBuses.push_back(i);
                break;
            }
        }
    }

    queue<pair<int, int>> q;
    vector<bool> visited(n, false);
    for (int bus : startBuses) {
        q.push({bus, 1});
        visited[bus] = true;
    }

    while (!q.empty()) {
        int bus = q.front().first;
        int count = q.front().second;
        q.pop();

        for (int stop : routes[bus]) {
            if (stop == target) return count;
        }

        for (int neighbor : adj[bus]) {
            if (!visited[neighbor]) {
                q.push({neighbor, count + 1});
                visited[neighbor] = true;
            }
        }
    }

    return -1;
}