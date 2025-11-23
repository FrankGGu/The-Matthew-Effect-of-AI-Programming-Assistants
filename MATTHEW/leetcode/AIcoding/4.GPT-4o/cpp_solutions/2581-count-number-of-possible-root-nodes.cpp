class Solution {
public:
    int countRootNodes(vector<vector<int>>& edges) {
        unordered_set<int> children;
        for (const auto& edge : edges) {
            children.insert(edge[1]);
        }
        int count = 0;
        for (const auto& edge : edges) {
            if (children.find(edge[0]) == children.end()) {
                count++;
            }
        }
        return count;
    }
};