#include <vector>
#include <queue>
#include <algorithm>

class Solution {
public:
    int chasingGame(int n, std::vector<std::vector<int>>& edges, int startA, int startB, int target) {
        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        // BFS to find shortest distances from startA for Player A
        std::vector<int> distA(n, -1);
        std::queue<int> q;

        q.push(startA);
        distA[startA] = 0;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            for (int v : adj[u]) {
                if (distA[v] == -1) {
                    distA[v] = distA[u] + 1;
                    q.push(v);
                }
            }
        }

        // BFS to find shortest distances from startB for Player B
        std::vector<int> distB(n, -1);
        q.push(startB);
        distB[startB] = 0;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            for (int v : adj[u]) {
                if (distB[v] == -1) {
                    distB[v] = distB[u] + 1;
                    q.push(v);
                }
            }
        }

        // Modified BFS for Player A to find the shortest path to target,
        // considering Player B's interception strategy.
        // `current_dist_A[u]` stores the minimum time for Player A to reach node `u`
        // such that all intermediate nodes on the path were safe from B's interception.
        std::vector<int> current_dist_A(n, -1); 

        q.push(startA);
        current_dist_A[startA] = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            int time_A_at_u = current_dist_A[u];

            // If Player A has reached the target, no need to explore further from target
            // in this specific path, as we are looking for the shortest path to target.
            // The `current_dist_A[target]` will hold the shortest valid time.
            // We continue the BFS to ensure all reachable nodes are processed and `current_dist_A[target]`
            // gets the true minimum if multiple paths exist.

            for (int v : adj[u]) {
                int time_A_at_v = time_A_at_u + 1;

                // If this path to v is longer or equal to an already found path, skip.
                if (current_dist_A[v] != -1 && time_A_at_v >= current_dist_A[v]) {
                    continue;
                }

                // Check B's interception condition:
                // If v is the target node: A wins if A arrives at or before B.
                // So, `time_A_at_v <= distB[v]` must be true.
                // If v is an intermediate node (not target): A must arrive strictly before B to pass through safely.
                // So, `time_A_at_v < distB[v]` must be true.

                if (v == target) {
                    if (time_A_at_v <= distB[v]) {
                        current_dist_A[v] = time_A_at_v;
                        q.push(v);
                    }
                } else {
                    if (time_A_at_v < distB[v]) {
                        current_dist_A[v] = time_A_at_v;
                        q.push(v);
                    }
                }
            }
        }

        return current_dist_A[target];
    }
};