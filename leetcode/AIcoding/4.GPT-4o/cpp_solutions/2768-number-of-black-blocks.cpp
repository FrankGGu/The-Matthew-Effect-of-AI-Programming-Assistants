class Solution {
public:
    int countBlackBlocks(int m, int n, vector<vector<int>>& coordinates) {
        vector<vector<int>> grid(m, vector<int>(n, 0));
        for (const auto& coord : coordinates) {
            grid[coord[0]][coord[1]]++;
        }

        unordered_map<int, int> blockCount;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] > 0) {
                    for (int x = 0; x <= 1; ++x) {
                        for (int y = 0; y <= 1; ++y) {
                            if (i + x < m && j + y < n) {
                                int blockId = (i + x) * n + (j + y);
                                blockCount[blockId] += grid[i][j];
                            }
                        }
                    }
                }
            }
        }

        int totalBlocks = 0;
        for (const auto& count : blockCount) {
            if (count.second > 0) {
                totalBlocks++;
            }
        }

        return totalBlocks;
    }
};