class Solution {
public:
    vector<int> findSmallestSetOfVertices(int n, vector<vector<int>>& edges) {
        vector<bool> hasIncomingEdge(n, false);
        for (const auto& edge : edges) {
            hasIncomingEdge[edge[1]] = true;
        }
        vector<int> result;
        for (int i = 0; i < n; ++i) {
            if (!hasIncomingEdge[i]) {
                result.push_back(i);
            }
        }
        return result;
    }
};