#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool areMatricesSimilar(vector<vector<int>>& matrix, vector<vector<int>>& target) {
        int rows = matrix.size();
        int cols = matrix[0].size();

        for (int i = 0; i < rows; ++i) {
            unordered_set<string> seen;
            for (int j = 0; j < cols; ++j) {
                string row;
                for (int k = 0; k < cols; ++k) {
                    row += to_string(matrix[i][(j + k) % cols]) + ",";
                }
                if (seen.find(row) != seen.end()) {
                    return false;
                }
                seen.insert(row);
            }
        }

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                string row;
                for (int k = 0; k < cols; ++k) {
                    row += to_string(target[i][(j + k) % cols]) + ",";
                }
                if (seen.find(row) == seen.end()) {
                    return false;
                }
            }
        }

        return true;
    }
};