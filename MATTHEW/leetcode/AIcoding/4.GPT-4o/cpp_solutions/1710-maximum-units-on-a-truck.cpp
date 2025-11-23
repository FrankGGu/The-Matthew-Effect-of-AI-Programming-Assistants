#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumUnits(std::vector<std::vector<int>>& boxTypes, int truckSize) {
        std::sort(boxTypes.begin(), boxTypes.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[1] > b[1];
        });

        int totalUnits = 0;
        for (const auto& box : boxTypes) {
            if (truckSize == 0) break;
            int boxesToTake = std::min(box[0], truckSize);
            totalUnits += boxesToTake * box[1];
            truckSize -= boxesToTake;
        }

        return totalUnits;
    }
};