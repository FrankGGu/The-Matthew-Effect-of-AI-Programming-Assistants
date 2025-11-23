#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maximumRowsCovered(vector<vector<char>>& matrix, int n, int m, int k) {
        vector<unordered_set<int>> rowSet(n);
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (matrix[i][j] == '1') {
                    rowSet[i].insert(j);
                }
            }
        }

        vector<int> colIndices(m);
        for (int i = 0; i < m; ++i) {
            colIndices[i] = i;
        }

        int maxRows = 0;
        vector<bool> used(m, false);

        function<void(int, int, int)> backtrack = [&](int start, int count, int covered) {
            if (count == k) {
                maxRows = max(maxRows, covered);
                return;
            }

            for (int i = start; i < m; ++i) {
                if (!used[i]) {
                    used[i] = true;
                    int newCovered = covered;
                    for (int r = 0; r < n; ++r) {
                        if (rowSet[r].find(i) != rowSet[r].end()) {
                            newCovered++;
                        }
                    }
                    backtrack(i + 1, count + 1, newCovered);
                    used[i] = false;
                }
            }
        };

        backtrack(0, 0, 0);
        return maxRows;
    }
};