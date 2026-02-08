#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> sortTheStudents(vector<vector<int>>& score, int k) {
        int m = score.size();
        vector<int> indices(m);
        for (int i = 0; i < m; ++i) {
            indices[i] = i;
        }

        sort(indices.begin(), indices.end(), [&](int i, int j) {
            return score[i][k] > score[j][k];
        });

        vector<vector<int>> result(m);
        for (int i = 0; i < m; ++i) {
            result[i] = score[indices[i]];
        }

        return result;
    }
};