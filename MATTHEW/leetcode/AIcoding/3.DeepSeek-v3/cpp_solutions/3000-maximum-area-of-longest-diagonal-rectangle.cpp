class Solution {
public:
    int areaOfMaxDiagonal(vector<vector<int>>& dimensions) {
        int maxDiagonalSq = 0;
        int maxArea = 0;
        for (const auto& dim : dimensions) {
            int l = dim[0], w = dim[1];
            int diagonalSq = l * l + w * w;
            if (diagonalSq > maxDiagonalSq) {
                maxDiagonalSq = diagonalSq;
                maxArea = l * w;
            } else if (diagonalSq == maxDiagonalSq) {
                maxArea = max(maxArea, l * w);
            }
        }
        return maxArea;
    }
};