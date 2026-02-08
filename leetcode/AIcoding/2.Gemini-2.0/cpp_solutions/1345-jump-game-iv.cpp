#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

int minJumps(vector<int>& arr) {
    int n = arr.size();
    if (n <= 1) return 0;

    unordered_map<int, vector<int>> adj;
    for (int i = 0; i < n; i++) {
        adj[arr[i]].push_back(i);
    }

    vector<bool> visited(n, false);
    queue<int> q;
    q.push(0);
    visited[0] = true;
    int steps = 0;

    while (!q.empty()) {
        int size = q.size();
        for (int i = 0; i < size; i++) {
            int u = q.front();
            q.pop();

            if (u == n - 1) return steps;

            vector<int>& neighbors = adj[arr[u]];
            neighbors.push_back(u - 1);
            neighbors.push_back(u + 1);

            for (int v : neighbors) {
                if (v >= 0 && v < n && !visited[v]) {
                    q.push(v);
                    visited[v] = true;
                }
            }
            neighbors.clear();
        }
        steps++;
    }

    return -1;
}