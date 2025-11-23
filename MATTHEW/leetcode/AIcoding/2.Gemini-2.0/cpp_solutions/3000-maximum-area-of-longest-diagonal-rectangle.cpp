#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int areaOfMaxDiagonal(vector<vector<int>>& dimensions) {
        double max_diagonal = 0.0;
        int max_area = 0;

        for (const auto& dim : dimensions) {
            int l = dim[0];
            int w = dim[1];
            double diagonal = sqrt(l * l + w * w);
            int area = l * w;

            if (diagonal > max_diagonal) {
                max_diagonal = diagonal;
                max_area = area;
            } else if (diagonal == max_diagonal && area > max_area) {
                max_area = area;
            }
        }

        return max_area;
    }
};