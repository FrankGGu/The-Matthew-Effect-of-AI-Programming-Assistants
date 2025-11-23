#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> buildMatrix(int k, vector<vector<int>>& rowConditions, vector<vector<int>>& colConditions) {
        vector<int> row_indegree(k + 1, 0);
        vector<int> col_indegree(k + 1, 0);

        vector<vector<int>> row_adj(k + 1);
        vector<vector<int>> col_adj(k + 1);

        for (auto& condition : rowConditions) {
            row_adj[condition[0]].push_back(condition[1]);
            row_indegree[condition[1]]++;
        }

        for (auto& condition : colConditions) {
            col_adj[condition[0]].push_back(condition[1]);
            col_indegree[condition[1]]++;
        }

        queue<int> row_q;
        queue<int> col_q;

        for (int i = 1; i <= k; ++i) {
            if (row_indegree[i] == 0) {
                row_q.push(i);
            }
            if (col_indegree[i] == 0) {
                col_q.push(i);
            }
        }

        vector<int> row_order;
        vector<int> col_order;

        while (!row_q.empty()) {
            int u = row_q.front();
            row_q.pop();
            row_order.push_back(u);

            for (int v : row_adj[u]) {
                row_indegree[v]--;
                if (row_indegree[v] == 0) {
                    row_q.push(v);
                }
            }
        }

        while (!col_q.empty()) {
            int u = col_q.front();
            col_q.pop();
            col_order.push_back(u);

            for (int v : col_adj[u]) {
                col_indegree[v]--;
                if (col_indegree[v] == 0) {
                    col_q.push(v);
                }
            }
        }

        if (row_order.size() != k || col_order.size() != k) {
            return {};
        }

        vector<vector<int>> result(k, vector<int>(k, 0));
        vector<int> col_pos(k + 1);
        for (int i = 0; i < k; ++i) {
            col_pos[col_order[i]] = i;
        }

        for (int i = 0; i < k; ++i) {
            result[i][col_pos[row_order[i]]] = row_order[i];
        }

        return result;
    }
};