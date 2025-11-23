class Solution {
public:
    vector<vector<int>> findCriticalAndPseudoCriticalEdges(int n, vector<vector<int>>& edges) {
        int m = edges.size();
        for (int i = 0; i < m; ++i) {
            edges[i].push_back(i);
        }
        sort(edges.begin(), edges.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });

        int minCost = kruskal(n, edges, -1, -1);
        vector<int> critical, pseudo;

        for (int i = 0; i < m; ++i) {
            int cost = kruskal(n, edges, i, -1);
            if (cost > minCost) {
                critical.push_back(edges[i][3]);
            } else {
                cost = kruskal(n, edges, -1, i);
                if (cost == minCost) {
                    pseudo.push_back(edges[i][3]);
                }
            }
        }

        return {critical, pseudo};
    }

private:
    int kruskal(int n, vector<vector<int>>& edges, int exclude, int include) {
        vector<int> parent(n);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        int cost = 0;
        int count = 0;

        if (include != -1) {
            int u = edges[include][0];
            int v = edges[include][1];
            int rootU = find(parent, u);
            int rootV = find(parent, v);
            parent[rootU] = rootV;
            cost += edges[include][2];
            count++;
        }

        for (int i = 0; i < edges.size(); ++i) {
            if (i == exclude) continue;
            int u = edges[i][0];
            int v = edges[i][1];
            int rootU = find(parent, u);
            int rootV = find(parent, v);
            if (rootU != rootV) {
                parent[rootU] = rootV;
                cost += edges[i][2];
                count++;
            }
        }

        return count == n - 1 ? cost : INT_MAX;
    }

    int find(vector<int>& parent, int x) {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }
};