class Solution {
public:
    int maxStarSum(vector<int>& vals, vector<vector<int>>& edges, int k) {
        int n = vals.size();
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        int maxSum = 0;
        for (int i = 0; i < n; ++i) {
            int currentSum = vals[i];
            vector<int> neighbors;
            for (int neighbor : graph[i]) {
                neighbors.push_back(vals[neighbor]);
            }
            sort(neighbors.rbegin(), neighbors.rend());
            for (int j = 0; j < min(k, (int)neighbors.size()); ++j) {
                if (neighbors[j] > 0) {
                    currentSum += neighbors[j];
                } else {
                    break;
                }
            }
            maxSum = max(maxSum, currentSum);
        }
        return maxSum;
    }
};