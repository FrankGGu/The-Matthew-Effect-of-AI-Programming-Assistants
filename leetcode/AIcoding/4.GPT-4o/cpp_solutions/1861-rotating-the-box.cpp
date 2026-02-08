class Solution {
public:
    vector<vector<char>> rotateTheBox(vector<vector<char>>& box) {
        int m = box.size(), n = box[0].size();
        vector<vector<char>> rotated(n, vector<char>(m, '.'));

        for (int i = 0; i < m; ++i) {
            int j = n - 1;
            for (int k = n - 1; k >= 0; --k) {
                if (box[i][k] == '#') {
                    rotated[j--][i] = '#';
                } else if (box[i][k] == '*') {
                    while (j >= 0 && rotated[j][i] == '#') --j;
                    rotated[j--][i] = '*';
                }
            }
            while (j >= 0) rotated[j--][i] = '.';
        }

        return rotated;
    }
};