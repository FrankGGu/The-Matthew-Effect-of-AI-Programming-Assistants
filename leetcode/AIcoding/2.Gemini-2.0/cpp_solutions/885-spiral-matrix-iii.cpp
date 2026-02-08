#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> spiralMatrixIII(int rows, int cols, int rStart, int cStart) {
        vector<vector<int>> result;
        int layer = 0;
        int row = rStart, col = cStart;
        result.push_back({row, col});
        int total = rows * cols;
        while (result.size() < total) {
            layer++;
            for (int i = 0; i < 2 * layer; i++) {
                col++;
                if (row >= 0 && row < rows && col >= 0 && col < cols) {
                    result.push_back({row, col});
                }
            }
            for (int i = 0; i < 2 * layer; i++) {
                row++;
                if (row >= 0 && row < rows && col >= 0 && col < cols) {
                    result.push_back({row, col});
                }
            }
            for (int i = 0; i < 2 * layer; i++) {
                col--;
                if (row >= 0 && row < rows && col >= 0 && col < cols) {
                    result.push_back({row, col});
                }
            }
            for (int i = 0; i < 2 * layer; i++) {
                row--;
                if (row >= 0 && row < rows && col >= 0 && col < cols) {
                    result.push_back({row, col});
                }
            }
        }
        return result;
    }
};