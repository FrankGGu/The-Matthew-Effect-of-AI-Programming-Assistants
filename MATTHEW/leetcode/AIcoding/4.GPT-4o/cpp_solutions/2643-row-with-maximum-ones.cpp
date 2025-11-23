class Solution {
public:
    vector<int> rowAndMaximumOnes(vector<vector<int>>& mat) {
        int maxCount = 0, rowIndex = -1;
        for (int i = 0; i < mat.size(); ++i) {
            int count = count(mat[i].begin(), mat[i].end(), 1);
            if (count > maxCount) {
                maxCount = count;
                rowIndex = i;
            }
        }
        return {rowIndex, maxCount};
    }
};