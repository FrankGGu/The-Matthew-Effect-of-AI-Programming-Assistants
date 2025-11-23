class Solution {
public:
    int minTotalDistance(vector<vector<int>>& grid) {
        vector<int> rows, cols;
        for (int i = 0; i < grid.size(); ++i) {
            for (int j = 0; j < grid[0].size(); ++j) {
                if (grid[i][j]) {
                    rows.push_back(i);
                    cols.push_back(j);
                }
            }
        }
        return getMedianDistance(rows) + getMedianDistance(cols);
    }

    int getMedianDistance(vector<int>& coords) {
        sort(coords.begin(), coords.end());
        int median = coords[coords.size() / 2];
        int distance = 0;
        for (int coord : coords) {
            distance += abs(coord - median);
        }
        return distance;
    }
};