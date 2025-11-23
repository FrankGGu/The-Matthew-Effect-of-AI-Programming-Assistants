#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool checkValid(vector<vector<int>>& matrix) {
        int n = matrix.size();
        for (int i = 0; i < n; ++i) {
            unordered_set<int> rowSet;
            unordered_set<int> colSet;
            for (int j = 0; j < n; ++j) {
                if (rowSet.find(matrix[i][j]) != rowSet.end() || matrix[i][j] < 1 || matrix[i][j] > n)
                    return false;
                rowSet.insert(matrix[i][j]);
                if (colSet.find(matrix[j][i]) != colSet.end() || matrix[j][i] < 1 || matrix[j][i] > n)
                    return false;
                colSet.insert(matrix[j][i]);
            }
        }
        return true;
    }
};