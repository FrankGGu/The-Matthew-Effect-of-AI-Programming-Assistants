class Solution {
public:
    string kthSmallestPath(vector<int>& destination, int k) {
        int v = destination[0], h = destination[1];
        vector<vector<int>> comb(h + v, vector<int>(h + v, 1));
        for (int i = 1; i < h + v; ++i) {
            for (int j = 1; j < i; ++j) {
                comb[i][j] = comb[i - 1][j - 1] + comb[i - 1][j];
            }
        }
        string res;
        for (int i = 0; i < h + v; ++i) {
            if (h > 0) {
                int c = comb[h + v - i - 1][h - 1];
                if (k > c) {
                    res += 'V';
                    v--;
                    k -= c;
                } else {
                    res += 'H';
                    h--;
                }
            } else {
                res += 'V';
                v--;
            }
        }
        return res;
    }
};