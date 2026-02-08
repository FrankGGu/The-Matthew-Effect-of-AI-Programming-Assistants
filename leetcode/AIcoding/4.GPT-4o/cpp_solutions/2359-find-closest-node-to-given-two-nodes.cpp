class Solution {
public:
    int closestMeetingNode(vector<int>& edges, int node1, int node2) {
        vector<int> dist1(edges.size(), -1), dist2(edges.size(), -1);
        bfs(edges, node1, dist1);
        bfs(edges, node2, dist2);

        int minDist = INT_MAX, result = -1;
        for (int i = 0; i < edges.size(); ++i) {
            if (dist1[i] != -1 && dist2[i] != -1) {
                int maxDist = max(dist1[i], dist2[i]);
                if (maxDist < minDist) {
                    minDist = maxDist;
                    result = i;
                } else if (maxDist == minDist) {
                    result = min(result, i);
                }
            }
        }
        return result;
    }

    void bfs(vector<int>& edges, int start, vector<int>& dist) {
        queue<int> q;
        q.push(start);
        dist[start] = 0;
        while (!q.empty()) {
            int node = q.front();
            q.pop();
            if (edges[node] != -1 && dist[edges[node]] == -1) {
                dist[edges[node]] = dist[node] + 1;
                q.push(edges[node]);
            }
        }
    }
};