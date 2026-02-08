class Solution {
public:
    vector<vector<string>> renameColumns(vector<vector<string>>& A) {
        vector<vector<string>> result;
        for (int j = 0; j < A[0].size(); ++j) {
            unordered_map<string, int> count;
            for (int i = 0; i < A.size(); ++i) {
                count[A[i][j]]++;
            }
            for (int i = 0; i < A.size(); ++i) {
                if (count[A[i][j]] > 1) {
                    result[i].push_back(A[i][j] + "_" + to_string(count[A[i][j]]--));
                } else {
                    result[i].push_back(A[i][j]);
                }
            }
        }
        return result;
    }
};