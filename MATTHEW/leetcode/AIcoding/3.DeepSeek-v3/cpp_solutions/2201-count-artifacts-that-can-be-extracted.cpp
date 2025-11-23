class Solution {
public:
    int digArtifacts(int n, vector<vector<int>>& artifacts, vector<vector<int>>& dig) {
        vector<vector<bool>> grid(n, vector<bool>(n, false));
        for (auto& d : dig) {
            grid[d[0]][d[1]] = true;
        }

        int count = 0;
        for (auto& art : artifacts) {
            int r1 = art[0], c1 = art[1], r2 = art[2], c2 = art[3];
            bool canExtract = true;
            for (int i = r1; i <= r2; ++i) {
                for (int j = c1; j <= c2; ++j) {
                    if (!grid[i][j]) {
                        canExtract = false;
                        break;
                    }
                }
                if (!canExtract) break;
            }
            if (canExtract) count++;
        }
        return count;
    }
};