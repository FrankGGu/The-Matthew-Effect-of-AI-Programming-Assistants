class Solution {
public:
    int minSwapsCouples(vector<int>& row) {
        int n = row.size();
        vector<int> pos(n);
        for (int i = 0; i < n; ++i) {
            pos[row[i]] = i;
        }
        int res = 0;
        for (int i = 0; i < n; i += 2) {
            int x = row[i];
            int y = x ^ 1;
            if (row[i + 1] != y) {
                int j = pos[y];
                swap(row[i + 1], row[j]);
                pos[row[j]] = j;
                pos[row[i + 1]] = i + 1;
                ++res;
            }
        }
        return res;
    }
};