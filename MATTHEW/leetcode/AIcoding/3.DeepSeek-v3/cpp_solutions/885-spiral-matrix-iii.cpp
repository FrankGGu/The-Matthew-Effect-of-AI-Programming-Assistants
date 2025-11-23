class Solution {
public:
    vector<vector<int>> spiralMatrixIII(int rows, int cols, int rStart, int cStart) {
        vector<vector<int>> res;
        int step = 1;
        int count = 0;
        int total = rows * cols;
        res.push_back({rStart, cStart});
        count++;

        while (count < total) {
            for (int i = 0; i < step; i++) {
                cStart++;
                if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                    res.push_back({rStart, cStart});
                    count++;
                }
            }
            for (int i = 0; i < step; i++) {
                rStart++;
                if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                    res.push_back({rStart, cStart});
                    count++;
                }
            }
            step++;
            for (int i = 0; i < step; i++) {
                cStart--;
                if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                    res.push_back({rStart, cStart});
                    count++;
                }
            }
            for (int i = 0; i < step; i++) {
                rStart--;
                if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                    res.push_back({rStart, cStart});
                    count++;
                }
            }
            step++;
        }

        return res;
    }
};