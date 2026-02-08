class Solution {
public:
    vector<vector<int>> reconstructMatrix(int upper, int lower, vector<int>& colsum) {
        int total = 0;
        for (int sum : colsum) total += sum;
        if (total != upper + lower) return {};

        vector<vector<int>> result(2, vector<int>(colsum.size(), 0));

        for (int i = 0; i < colsum.size(); ++i) {
            if (colsum[i] == 2) {
                result[0][i] = result[1][i] = 1;
                upper--;
                lower--;
            } else if (colsum[i] == 1) {
                if (upper > lower) {
                    result[0][i] = 1;
                    upper--;
                } else {
                    result[1][i] = 1;
                    lower--;
                }
            }
        }

        return (upper == 0 && lower == 0) ? result : vector<vector<int>>();
    }
};