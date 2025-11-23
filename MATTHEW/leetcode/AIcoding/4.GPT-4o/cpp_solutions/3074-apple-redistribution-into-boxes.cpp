#include <vector>
#include <algorithm>

class Solution {
public:
    int minBoxes(std::vector<int>& boxes) {
        int n = boxes.size();
        std::sort(boxes.begin(), boxes.end(), std::greater<int>());
        int totalBoxes = 0;
        int totalApples = 0;

        for (int i = 0; i < n; ++i) {
            totalApples += boxes[i];
            totalBoxes++;
            if (totalApples <= totalBoxes * (totalBoxes + 1) / 2) {
                return totalBoxes;
            }
        }

        return totalBoxes;
    }
};