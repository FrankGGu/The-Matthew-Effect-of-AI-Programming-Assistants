class Solution {
public:
    vector<vector<int>> spiralMatrixIII(int rows, int cols, int rStart, int cStart) {
        vector<vector<int>> result;
        vector<int> directions = {0, 1, 1, 0, 0, -1, -1, 0}; // right, down, left, up
        int steps = 0, d = 0;

        while (result.size() < rows * cols) {
            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < steps + (i == 1); j++) {
                    if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                        result.push_back({rStart, cStart});
                    }
                    rStart += directions[d];
                    cStart += directions[d + 1];
                }
                d = (d + 2) % 8;
            }
            steps++;
        }

        return result;
    }
};