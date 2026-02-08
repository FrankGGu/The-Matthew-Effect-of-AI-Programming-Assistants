#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    long long countSubmatrices(std::vector<std::vector<char>>& grid) {
        int R = grid.size();
        int C = grid[0].size();

        std::vector<std::vector<int>> diff(R, std::vector<int>(C));
        for (int i = 0; i < R; ++i) {
            for (int j = 0; j < C; ++j) {
                if (grid[i][j] == 'X') {
                    diff[i][j] = 1;
                } else if (grid[i][j] == 'Y') {
                    diff[i][j] = -1;
                } else {
                    diff[i][j] = 0;
                }
            }
        }

        long long ans = 0;

        for (int r1 = 0; r1 < R; ++r1) {
            std::vector<int> row_sum(C, 0); 
            for (int r2 = r1; r2 < R; ++r2) {
                for (int j = 0; j < C; ++j) {
                    row_sum[j] += diff[r2][j];
                }

                std::unordered_map<int, int> freq_map;
                freq_map[0] = 1; 
                int current_prefix_sum = 0;

                for (int j = 0; j < C; ++j) {
                    current_prefix_sum += row_sum[j];
                    if (freq_map.count(current_prefix_sum)) {
                        ans += freq_map[current_prefix_sum];
                    }
                    freq_map[current_prefix_sum]++;
                }
            }
        }

        return ans;
    }
};