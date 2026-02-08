class Solution {
public:
    vector<int> bestCoordinate(vector<vector<int>>& towers, int radius) {
        int maxX = 0, maxY = 0;
        for (const auto& tower : towers) {
            maxX = max(maxX, tower[0]);
            maxY = max(maxY, tower[1]);
        }

        vector<vector<int>> grid(maxX + 1, vector<int>(maxY + 1, 0));
        for (const auto& tower : towers) {
            int x = tower[0], y = tower[1], q = tower[2];
            for (int i = max(0, x - radius); i <= min(maxX, x + radius); ++i) {
                for (int j = max(0, y - radius); j <= min(maxY, y + radius); ++j) {
                    if (sqrt(pow(x - i, 2) + pow(y - j, 2)) <= radius) {
                        grid[i][j] += q;
                    }
                }
            }
        }

        int maxSignal = 0;
        vector<int> bestCoord;
        for (int i = 0; i <= maxX; ++i) {
            for (int j = 0; j <= maxY; ++j) {
                if (grid[i][j] > maxSignal) {
                    maxSignal = grid[i][j];
                    bestCoord = {i, j};
                } else if (grid[i][j] == maxSignal) {
                    if (bestCoord.empty() || i < bestCoord[0] || (i == bestCoord[0] && j < bestCoord[1])) {
                        bestCoord = {i, j};
                    }
                }
            }
        }
        return bestCoord;
    }
};