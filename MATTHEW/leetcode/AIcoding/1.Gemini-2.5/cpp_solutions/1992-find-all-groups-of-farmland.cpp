class Solution {
public:
    std::vector<std::vector<int>> findFarmland(std::vector<std::vector<int>>& land) {
        std::vector<std::vector<int>> result;
        int m = land.size();
        int n = land[0].size();

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (land[r][c] == 1) {
                    // Found the top-left corner of a farmland group
                    int r1 = r;
                    int c1 = c;

                    // Find the bottom-right corner (r2, c2)
                    // Extend right to find c2
                    int c2 = c;
                    while (c2 + 1 < n && land[r][c2 + 1] == 1) {
                        c2++;
                    }

                    // Extend down to find r2
                    int r2 = r;
                    while (r2 + 1 < m && land[r2 + 1][c] == 1) {
                        r2++;
                    }

                    // Add the group to the result
                    result.push_back({r1, c1, r2, c2});

                    // Mark all cells in this group as visited (0)
                    // to prevent re-processing
                    for (int i = r1; i <= r2; ++i) {
                        for (int j = c1; j <= c2; ++j) {
                            land[i][j] = 0;
                        }
                    }
                }
            }
        }
        return result;
    }
};