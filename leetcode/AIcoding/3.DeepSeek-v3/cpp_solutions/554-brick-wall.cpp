class Solution {
public:
    int leastBricks(vector<vector<int>>& wall) {
        unordered_map<int, int> edgeCount;
        int maxEdges = 0;
        for (const auto& row : wall) {
            int edgePosition = 0;
            for (int i = 0; i < row.size() - 1; ++i) {
                edgePosition += row[i];
                edgeCount[edgePosition]++;
                maxEdges = max(maxEdges, edgeCount[edgePosition]);
            }
        }
        return wall.size() - maxEdges;
    }
};