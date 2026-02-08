#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string decodeCiphertext(string s, int rows) {
        int n = s.size();
        int cols = (n + rows - 1) / rows;
        vector<vector<char>> grid(rows, vector<char>(cols, ' '));

        int index = 0;
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols && index < n; ++j) {
                grid[i][j] = s[index++];
            }
        }

        string result;
        for (int j = 0; j < cols; ++j) {
            for (int i = 0; i < rows; ++i) {
                if (grid[i][j] != ' ') {
                    result += grid[i][j];
                }
            }
        }

        return result;
    }
};