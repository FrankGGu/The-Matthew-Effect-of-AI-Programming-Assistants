#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countCells(int n, int m, vector<string>& s) {
        vector<vector<bool>> marked(n, vector<bool>(m, false));
        int count = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (s[i][j] == '1') {
                    for (int k = j; k < m && s[i][k] == '1'; ++k) {
                        if (!marked[i][k]) {
                            marked[i][k] = true;
                            ++count;
                        }
                    }
                    for (int k = i; k < n && s[k][j] == '1'; ++k) {
                        if (!marked[k][j]) {
                            marked[k][j] = true;
                            ++count;
                        }
                    }
                }
            }
        }

        return count;
    }
};