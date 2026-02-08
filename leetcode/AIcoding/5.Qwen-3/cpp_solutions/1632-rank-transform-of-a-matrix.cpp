#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> arrayRankTransform(vector<vector<int>>& matrix) {
        int rows = matrix.size();
        int cols = matrix[0].size();

        map<int, int> rankMap;
        set<int> uniqueValues;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                uniqueValues.insert(matrix[i][j]);
            }
        }

        int rank = 1;
        for (int val : uniqueValues) {
            rankMap[val] = rank++;
        }

        vector<vector<int>> result(rows, vector<int>(cols));

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                result[i][j] = rankMap[matrix[i][j]];
            }
        }

        return result;
    }
};