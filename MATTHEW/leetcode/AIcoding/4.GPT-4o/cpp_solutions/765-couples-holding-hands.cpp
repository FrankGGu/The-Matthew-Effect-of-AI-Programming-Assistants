class Solution {
public:
    int minSwapsCouples(vector<int>& row) {
        int n = row.size() / 2;
        vector<int> pos(n);
        for (int i = 0; i < row.size(); i++) {
            pos[row[i] / 2] = i;
        }

        int swaps = 0;
        for (int i = 0; i < row.size(); i += 2) {
            int couple = row[i] ^ 1;
            if (row[i + 1] != couple) {
                swaps++;
                int j = pos[couple];
                swap(row[i + 1], row[j]);
                pos[row[j] / 2] = j;
                pos[couple] = i + 1;
            }
        }
        return swaps;
    }
};