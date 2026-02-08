#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> kWeakestRows(vector<vector<int>>& mat, int k) {
        int m = mat.size();
        vector<pair<int, int>> power_index;
        for (int i = 0; i < m; ++i) {
            int power = 0;
            for (int j = 0; j < mat[i].size(); ++j) {
                if (mat[i][j] == 1) {
                    power++;
                } else {
                    break;
                }
            }
            power_index.push_back({power, i});
        }

        sort(power_index.begin(), power_index.end());

        vector<int> result;
        for (int i = 0; i < k; ++i) {
            result.push_back(power_index[i].second);
        }

        return result;
    }
};