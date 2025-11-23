class Solution {
public:
    int findChampion(std::vector<std::vector<int>>& grid) {
        int n = grid.size();
        for (int i = 0; i < n; ++i) {
            bool is_champion = true;
            for (int j = 0; j < n; ++j) {
                if (i == j) {
                    continue;
                }
                if (grid[i][j] == 0) {
                    is_champion = false;
                    break;
                }
            }
            if (is_champion) {
                return i;
            }
        }
        return -1; // Should not be reached based on problem constraints
    }
};