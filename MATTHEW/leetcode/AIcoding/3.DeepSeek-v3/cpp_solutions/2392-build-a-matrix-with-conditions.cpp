class Solution {
public:
    vector<vector<int>> buildMatrix(int k, vector<vector<int>>& rowConditions, vector<vector<int>>& colConditions) {
        vector<int> rowOrder = topologicalSort(k, rowConditions);
        vector<int> colOrder = topologicalSort(k, colConditions);

        if (rowOrder.empty() || colOrder.empty()) {
            return {};
        }

        vector<int> rowPos(k + 1), colPos(k + 1);
        for (int i = 0; i < k; ++i) {
            rowPos[rowOrder[i]] = i;
            colPos[colOrder[i]] = i;
        }

        vector<vector<int>> matrix(k, vector<int>(k, 0));
        for (int num = 1; num <= k; ++num) {
            matrix[rowPos[num]][colPos[num]] = num;
        }

        return matrix;
    }

private:
    vector<int> topologicalSort(int k, vector<vector<int>>& conditions) {
        vector<vector<int>> adj(k + 1);
        vector<int> inDegree(k + 1, 0);

        for (const auto& cond : conditions) {
            int u = cond[0], v = cond[1];
            adj[u].push_back(v);
            inDegree[v]++;
        }

        queue<int> q;
        for (int i = 1; i <= k; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        vector<int> order;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            order.push_back(u);

            for (int v : adj[u]) {
                if (--inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        if (order.size() != k) {
            return {};
        }

        return order;
    }
};