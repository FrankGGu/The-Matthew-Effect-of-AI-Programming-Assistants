#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> findMissingAndRepeatedValues(int n, int m, vector<vector<int>>& grid) {
        unordered_map<int, int> count;
        vector<int> result(2, 0);
        int total = n * m;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                int num = grid[i][j];
                count[num]++;
            }
        }
        for (int i = 1; i <= total; ++i) {
            if (count[i] == 0) {
                result[0] = i;
            } else if (count[i] > 1) {
                result[1] = i;
            }
        }
        return result;
    }
};