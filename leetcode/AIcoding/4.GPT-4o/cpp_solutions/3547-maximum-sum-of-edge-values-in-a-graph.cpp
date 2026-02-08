class Solution {
public:
    int maxSumEdges(vector<vector<int>>& edges) {
        int n = edges.size();
        vector<int> maxEdge(n, 0);
        for (const auto& edge : edges) {
            maxEdge[edge[0]] = max(maxEdge[edge[0]], edge[2]);
            maxEdge[edge[1]] = max(maxEdge[edge[1]], edge[2]);
        }
        int totalSum = 0;
        for (int val : maxEdge) {
            totalSum += val;
        }
        return totalSum;
    }
};