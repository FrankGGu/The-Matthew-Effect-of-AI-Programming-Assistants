class Solution {
public:
    vector<vector<int>> flipAndInvertImage(vector<vector<int>>& A) {
        for (auto& row : A) {
            reverse(row.begin(), row.end());
            for (auto& pixel : row) {
                pixel = pixel == 0 ? 1 : 0;
            }
        }
        return A;
    }
};