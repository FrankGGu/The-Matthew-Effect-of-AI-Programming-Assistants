class Solution {
public:
    int leastBricks(vector<vector<int>>& wall) {
        unordered_map<int, int> widthCount;
        int maxCount = 0;

        for (const auto& row : wall) {
            int width = 0;
            for (int i = 0; i < row.size() - 1; ++i) {
                width += row[i];
                widthCount[width]++;
                maxCount = max(maxCount, widthCount[width]);
            }
        }

        return wall.size() - maxCount;
    }
};