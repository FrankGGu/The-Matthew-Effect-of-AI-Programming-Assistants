#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> findMatrix(int n, int k) {
        vector<vector<int>> result(2, vector<int>(n, 0));
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (count < k) {
                result[0][i] = 1;
                count++;
            } else {
                result[1][i] = 1;
            }
        }
        return result;
    }
};