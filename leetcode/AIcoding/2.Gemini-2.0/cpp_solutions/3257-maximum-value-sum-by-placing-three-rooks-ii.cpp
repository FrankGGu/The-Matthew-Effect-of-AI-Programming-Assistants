#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long solve(int n, vector<int>& a, vector<vector<int>>& queries) {
        long long ans = 0;
        vector<int> b = a;
        for (auto& q : queries) {
            int r = q[0], c = q[1];
            swap(b[r], b[c]);
        }
        vector<int> row(n, 0), col(n, 0);
        for (int i = 0; i < n; ++i) {
            row[i] = b[i];
            col[i] = b[i];
        }

        vector<int> rook_rows, rook_cols;
        long long max_sum = 0;

        function<void(int, int, long long)> place_rooks = 
            [&](int row_idx, int col_idx, long long current_sum) {
            if (rook_rows.size() == 3) {
                max_sum = max(max_sum, current_sum);
                return;
            }

            if (row_idx >= n) return;
            if (col_idx >= n) return;

            bool row_used = false;
            for (int r : rook_rows) {
                if (r == row_idx) {
                    row_used = true;
                    break;
                }
            }
            bool col_used = false;
            for (int c : rook_cols) {
                if (c == col_idx) {
                    col_used = true;
                    break;
                }
            }

            place_rooks(row_idx + 1, 0, current_sum);
            if(!row_used){
                rook_rows.push_back(row_idx);
                place_rooks(row_idx + 1, 0, current_sum + row[row_idx]);
                rook_rows.pop_back();
            }

        };

        place_rooks(0, 0, 0);
        return max_sum;
    }
};