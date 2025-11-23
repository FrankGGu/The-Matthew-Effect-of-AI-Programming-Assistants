class Solution {
public:
    int findBall(int n, vector<vector<int>>& grid) {
        vector<int> position(n);
        for (int i = 0; i < n; ++i) position[i] = i;

        for (const auto& row : grid) {
            vector<int> nextPosition(n, -1);
            for (int j = 0; j < n; ++j) {
                if (position[j] == -1) continue;
                int nextCol = j + row[j];
                if (nextCol < 0 || nextCol >= n || row[j] != row[nextCol]) {
                    nextPosition[j] = -1;
                } else {
                    nextPosition[nextCol] = position[j];
                }
            }
            position = nextPosition;
        }

        for (int i = 0; i < n; ++i) {
            if (position[i] != -1) return position[i];
        }
        return -1;
    }
};