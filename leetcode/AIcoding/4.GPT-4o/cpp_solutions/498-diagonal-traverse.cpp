class Solution {
public:
    vector<int> findDiagonalOrder(vector<vector<int>>& mat) {
        vector<int> result;
        if (mat.empty()) return result;

        int m = mat.size(), n = mat[0].size();
        for (int d = 0; d < m + n - 1; ++d) {
            int r = d < n ? 0 : d - n + 1;
            int c = d < n ? d : n - 1;
            vector<int> temp;
            while (r < m && c >= 0) {
                temp.push_back(mat[r][c]);
                r++;
                c--;
            }
            if (d % 2 == 0) {
                reverse(temp.begin(), temp.end());
            }
            result.insert(result.end(), temp.begin(), temp.end());
        }
        return result;
    }
};