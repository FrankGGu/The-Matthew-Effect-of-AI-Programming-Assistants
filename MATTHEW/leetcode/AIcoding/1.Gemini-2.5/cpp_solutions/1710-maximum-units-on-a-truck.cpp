#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumUnits(std::vector<std::vector<int>>& boxTypes, int truckSize) {
        std::sort(boxTypes.begin(), boxTypes.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[1] > b[1];
        });

        int totalUnits = 0;

        for (const auto& boxType : boxTypes) {
            int numberOfBoxes = boxType[0];
            int unitsPerBox = boxType[1];

            int boxesToLoad = std::min(numberOfBoxes, truckSize);

            totalUnits += boxesToLoad * unitsPerBox;
            truckSize -= boxesToLoad;

            if (truckSize == 0) {
                break;
            }
        }

        return totalUnits;
    }
};