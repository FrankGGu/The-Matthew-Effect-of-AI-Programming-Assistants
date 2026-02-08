#include <vector>

class Solution {
public:
    std::vector<std::vector<char>> rotateTheBox(std::vector<std::vector<char>>& box) {
        int m = box.size(); 
        int n = box[0].size(); 

        std::vector<std::vector<char>> rotated_box(n, std::vector<char>(m));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                rotated_box[j][m - 1 - i] = box[i][j];
            }
        }

        for (int j = 0; j < m; ++j) { 
            int write_ptr = n - 1; 

            for (int i = n - 1; i >= 0; --i) { 
                if (rotated_box[i][j] == '#') {
                    if (i != write_ptr) {
                        rotated_box[write_ptr][j] = '#';
                        rotated_box[i][j] = '.';
                    }
                    write_ptr--; 
                } else if (rotated_box[i][j] == '*') {
                    write_ptr = i - 1;
                }
            }
        }

        return rotated_box;
    }
};