#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxStarSum(vector<int>& vals, vector<vector<int>>& edges, int k) {
        int n = vals.size();
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        int maxSum = -1e9;
        for (int i = 0; i < n; ++i) {
            vector<int> neighbors;
            for (int neighbor : adj[i]) {
                if (vals[neighbor] > 0) {
                    neighbors.push_back(vals[neighbor]);
                }
            }
            sort(neighbors.rbegin(), neighbors.rend());

            int currentSum = vals[i];
            for (int j = 0; j < min((int)neighbors.size(), k); ++j) {
                currentSum += neighbors[j];
            }
            maxSum = max(maxSum, currentSum);
        }

        return maxSum;
    }
};