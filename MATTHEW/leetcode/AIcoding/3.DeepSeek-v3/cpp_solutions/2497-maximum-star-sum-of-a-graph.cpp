class Solution {
public:
    int maxStarSum(vector<int>& vals, vector<vector<int>>& edges, int k) {
        int n = vals.size();
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1];
            adj[u].push_back(v);
            adj[v].push_back(u);
        }

        int maxSum = INT_MIN;
        for (int i = 0; i < n; ++i) {
            vector<int> neighbors;
            for (int v : adj[i]) {
                neighbors.push_back(vals[v]);
            }
            sort(neighbors.rbegin(), neighbors.rend());
            int sum = vals[i];
            for (int j = 0; j < min(k, (int)neighbors.size()); ++j) {
                if (neighbors[j] > 0) {
                    sum += neighbors[j];
                } else {
                    break;
                }
            }
            maxSum = max(maxSum, sum);
        }
        return maxSum;
    }
};