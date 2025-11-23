#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<vector<int>> buildMatrix(int k, vector<vector<int>>& rowConditions, vector<vector<int>>& colConditions) {
        vector<vector<int>> result;
        vector<int> inDegreeRow(k, 0), inDegreeCol(k, 0);
        unordered_map<int, vector<int>> adjRow, adjCol;
        for (auto& cond : rowConditions) {
            adjRow[cond[1]].push_back(cond[0]);
            inDegreeRow[cond[0]]++;
        }
        for (auto& cond : colConditions) {
            adjCol[cond[1]].push_back(cond[0]);
            inDegreeCol[cond[0]]++;
        }

        vector<int> rowOrder = topologicalSort(inDegreeRow, adjRow);
        vector<int> colOrder = topologicalSort(inDegreeCol, adjCol);

        if (rowOrder.size() != k || colOrder.size() != k) return result;

        unordered_map<int, int> rowMap, colMap;
        for (int i = 0; i < k; ++i) {
            rowMap[rowOrder[i]] = i;
            colMap[colOrder[i]] = i;
        }

        result.resize(k, vector<int>(k, 0));
        for (int i = 0; i < k; ++i) {
            result[rowMap[i]][colMap[i]] = i;
        }

        return result;
    }

private:
    vector<int> topologicalSort(vector<int>& inDegree, unordered_map<int, vector<int>>& adj) {
        vector<int> order;
        queue<int> q;
        for (int i = 0; i < inDegree.size(); ++i) {
            if (inDegree[i] == 0) q.push(i);
        }

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            order.push_back(node);
            for (int neighbor : adj[node]) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) q.push(neighbor);
            }
        }

        return order;
    }
};