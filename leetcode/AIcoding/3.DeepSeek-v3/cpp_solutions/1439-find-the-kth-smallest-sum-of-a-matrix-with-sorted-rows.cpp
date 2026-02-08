class Solution {
public:
    int kthSmallest(vector<vector<int>>& mat, int k) {
        vector<int> row = mat[0];
        for(int i = 1; i < mat.size(); ++i) {
            vector<int> newRow;
            for(int j = 0; j < row.size(); ++j) {
                for(int l = 0; l < mat[i].size(); ++l) {
                    newRow.push_back(row[j] + mat[i][l]);
                }
            }
            sort(newRow.begin(), newRow.end());
            newRow.resize(min(k, (int)newRow.size()));
            row = newRow;
        }
        return row[k-1];
    }
};