class Solution {
public:
    int longestCycle(vector<int>& edges) {
        int n = edges.size();
        vector<int> visited(n, 0);
        int maxCycle = -1;

        for (int i = 0; i < n; ++i) {
            if (visited[i] == 0) {
                unordered_map<int, int> distance;
                distance[i] = 1;
                dfs(i, edges, visited, distance, maxCycle);
            }
        }

        return maxCycle;
    }

    void dfs(int node, vector<int>& edges, vector<int>& visited, unordered_map<int, int>& distance, int& maxCycle) {
        visited[node] = 1;
        int neighbor = edges[node];

        if (neighbor != -1) {
            if (visited[neighbor] == 0) {
                distance[neighbor] = distance[node] + 1;
                dfs(neighbor, edges, visited, distance, maxCycle);
            } else if (distance.find(neighbor) != distance.end()) {
                maxCycle = max(maxCycle, distance[node] - distance[neighbor] + 1);
            }
        }
    }
};