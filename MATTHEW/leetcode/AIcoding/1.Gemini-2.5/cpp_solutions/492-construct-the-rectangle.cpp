#include <vector>
#include <cmath>

class Solution {
public:
    std::vector<int> constructRectangle(int area) {
        int w = static_cast<int>(std::sqrt(area));
        while (area % w != 0) {
            w--;
        }
        int l = area / w;
        return {l, w};
    }
};