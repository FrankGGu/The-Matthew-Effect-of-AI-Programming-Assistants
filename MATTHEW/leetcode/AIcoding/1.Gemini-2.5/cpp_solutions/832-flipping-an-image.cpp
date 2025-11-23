#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> flipAndInvertImage(std::vector<std::vector<int>>& image) {
        int rows = image.size();
        for (int i = 0; i < rows; ++i) {
            int cols = image[i].size();
            for (int j = 0; j < (cols + 1) / 2; ++j) {
                int temp = image[i][j];
                image[i][j] = 1 - image[i][cols - 1 - j];
                image[i][cols - 1 - j] = 1 - temp;
            }
        }
        return image;
    }
};