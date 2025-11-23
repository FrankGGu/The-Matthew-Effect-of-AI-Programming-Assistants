#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> reconstructMatrix(int upper, int lower, vector<int>& colsum) {
        int n = colsum.size();
        vector<vector<int>> result(2, vector<int>(n, 0));
        int sum = 0;
        for (int i = 0; i < n; ++i) {
            sum += colsum[i];
        }
        if (sum != upper + lower) {
            return {};
        }

        for (int i = 0; i < n; ++i) {
            if (colsum[i] == 2) {
                result[0][i] = 1;
                result[1][i] = 1;
                upper--;
                lower--;
            }
        }

        if (upper < 0 || lower < 0) {
            return {};
        }

        for (int i = 0; i < n; ++i) {
            if (colsum[i] == 1) {
                if (upper > 0) {
                    result[0][i] = 1;
                    upper--;
                } else {
                    result[1][i] = 1;
                    lower--;
                }
            }
        }

        if (upper == 0 && lower == 0) {
            return result;
        } else {
            return {};
        }
    }
};