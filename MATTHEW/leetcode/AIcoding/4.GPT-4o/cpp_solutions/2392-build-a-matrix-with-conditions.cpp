class Solution {
public:
    vector<vector<int>> buildMatrix(int k, vector<vector<int>>& rowConditions, vector<vector<int>>& colConditions) {
        vector<vector<int>> result(k, vector<int>(k));
        vector<int> rowIndegree(k + 1, 0), colIndegree(k + 1, 0);
        vector<vector<int>> rowGraph(k + 1), colGraph(k + 1);

        for (const auto& condition : rowConditions) {
            rowGraph[condition[0]].push_back(condition[1]);
            rowIndegree[condition[1]]++;
        }

        for (const auto& condition : colConditions) {
            colGraph[condition[0]].push_back(condition[1]);
            colIndegree[condition[1]]++;
        }

        vector<int> rowOrder, colOrder;
        for (int i = 1; i <= k; ++i) {
            if (rowIndegree[i] == 0) rowOrder.push_back(i);
            if (colIndegree[i] == 0) colOrder.push_back(i);
        }

        for (int i = 0; i < rowOrder.size(); ++i) {
            int node = rowOrder[i];
            for (int neighbor : rowGraph[node]) {
                if (--rowIndegree[neighbor] == 0) {
                    rowOrder.push_back(neighbor);
                }
            }
        }

        for (int i = 0; i < colOrder.size(); ++i) {
            int node = colOrder[i];
            for (int neighbor : colGraph[node]) {
                if (--colIndegree[neighbor] == 0) {
                    colOrder.push_back(neighbor);
                }
            }
        }

        if (rowOrder.size() < k || colOrder.size() < k) return {};

        vector<int> rowPosition(k + 1), colPosition(k + 1);
        for (int i = 0; i < k; ++i) {
            rowPosition[rowOrder[i]] = i;
            colPosition[colOrder[i]] = i;
        }

        for (int i = 1; i <= k; ++i) {
            result[rowPosition[i]][colPosition[i]] = i;
        }

        return result;
    }
};