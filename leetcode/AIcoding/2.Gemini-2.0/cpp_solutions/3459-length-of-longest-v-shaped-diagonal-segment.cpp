#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestVShapedDiagonal(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        int ans = 1;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                for (int len = 2; len <= min(n, m); ++len) {
                    if (i - len + 1 < 0 || i + len - 1 >= n || j - len + 1 < 0 || j + len - 1 >= m) {
                        continue;
                    }

                    bool valid = true;
                    for (int k = 1; k < len; ++k) {
                        if (grid[i - k + 1][j - k + 1] >= grid[i - k][j - k] || grid[i + k - 1][j + k - 1] >= grid[i + k][j + k]) {
                            valid = false;
                            break;
                        }
                    }

                    for (int k = 1; k < len; ++k) {
                      if (grid[i - k + 1][j + k - 1] >= grid[i - k][j + k] || grid[i + k - 1][j - k + 1] >= grid[i + k][j - k]) {
                            valid = false;
                            break;
                        }
                    }

                    if (valid) {

                      bool vshape = true;

                      if(len > 1){

                        for(int k=1; k<len; k++){
                          if(grid[i][j] <= grid[i-k][j+k] || grid[i][j] <= grid[i-k][j-k] || grid[i][j] <= grid[i+k][j+k] || grid[i][j] <= grid[i+k][j-k]){
                            vshape = false;
                            break;
                          }
                        }

                        if(vshape){
                           ans = max(ans, len);
                        }
                      }

                    }
                }
            }
        }

        return ans;
    }
};