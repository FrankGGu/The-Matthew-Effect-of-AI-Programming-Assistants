class Solution {
public:
    vector<int> findMinHeightTrees(int n, vector<vector<int>>& edges) {
        if (n == 1) return {0};

        vector<unordered_set<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].insert(edge[1]);
            adj[edge[1]].insert(edge[0]);
        }

        queue<int> leaves;
        for (int i = 0; i < n; ++i) {
            if (adj[i].size() == 1) {
                leaves.push(i);
            }
        }

        while (n > 2) {
            int size = leaves.size();
            n -= size;
            for (int i = 0; i < size; ++i) {
                int leaf = leaves.front();
                leaves.pop();
                int neighbor = *adj[leaf].begin();
                adj[neighbor].erase(leaf);
                if (adj[neighbor].size() == 1) {
                    leaves.push(neighbor);
                }
            }
        }

        vector<int> res;
        while (!leaves.empty()) {
            res.push_back(leaves.front());
            leaves.pop();
        }
        return res;
    }
};