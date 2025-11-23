#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> findGoodSubset(vector<vector<int>>& matrix) {
        int rows = matrix.size();
        int cols = matrix[0].size();

        vector<int> result;

        for (int i = 0; i < rows; ++i) {
            unordered_set<int> seen;
            for (int j = 0; j < cols; ++j) {
                if (seen.find(matrix[i][j]) != seen.end()) {
                    result.push_back(i);
                    return result;
                }
                seen.insert(matrix[i][j]);
            }
        }

        return result;
    }
};