class Solution {
public:
    int maximalNetworkRank(int n, vector<vector<int>>& roads) {
        vector<unordered_set<int>> adj(n);
        for (auto& road : roads) {
            adj[road[0]].insert(road[1]);
            adj[road[1]].insert(road[0]);
        }
        int max_rank = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int rank = adj[i].size() + adj[j].size();
                if (adj[i].count(j)) {
                    rank--;
                }
                max_rank = max(max_rank, rank);
            }
        }
        return max_rank;
    }
};