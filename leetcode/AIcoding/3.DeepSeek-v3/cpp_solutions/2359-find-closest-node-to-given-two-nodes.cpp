class Solution {
public:
    void dfs(int node, vector<int>& edges, vector<int>& dist, vector<bool>& visited) {
        visited[node] = true;
        int neighbor = edges[node];
        if (neighbor != -1 && !visited[neighbor]) {
            dist[neighbor] = dist[node] + 1;
            dfs(neighbor, edges, dist, visited);
        }
    }

    int closestMeetingNode(vector<int>& edges, int node1, int node2) {
        int n = edges.size();
        vector<int> dist1(n, -1), dist2(n, -1);
        vector<bool> visited1(n, false), visited2(n, false);
        dist1[node1] = 0;
        dist2[node2] = 0;
        dfs(node1, edges, dist1, visited1);
        dfs(node2, edges, dist2, visited2);

        int minDist = INT_MAX;
        int result = -1;
        for (int i = 0; i < n; ++i) {
            if (dist1[i] != -1 && dist2[i] != -1) {
                int currentMax = max(dist1[i], dist2[i]);
                if (currentMax < minDist) {
                    minDist = currentMax;
                    result = i;
                }
            }
        }
        return result;
    }
};