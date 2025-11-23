#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int firstCompleteRowOrColumn(int n, vector<int>& r) {
        vector<int> row(n, 0);
        vector<int> col(n, 0);
        unordered_map<int, int> count;

        for (int i = 0; i < r.size(); ++i) {
            int val = r[i];
            count[val]++;
            if (count[val] == 1) {
                int row_idx = (val - 1) / n;
                int col_idx = (val - 1) % n;
                row[row_idx]++;
                col[col_idx]++;
                if (row[row_idx] == n || col[col_idx] == n) {
                    return i;
                }
            }
        }
        return -1;
    }
};