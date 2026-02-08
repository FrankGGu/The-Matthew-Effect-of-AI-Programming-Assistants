#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumUnits(vector<vector<int>>& boxTypes, int truckSize) {
        sort(boxTypes.begin(), boxTypes.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] > b[1];
        });

        int totalUnits = 0;
        for (const auto& boxType : boxTypes) {
            int numBoxes = boxType[0];
            int unitsPerBox = boxType[1];

            if (truckSize >= numBoxes) {
                totalUnits += numBoxes * unitsPerBox;
                truckSize -= numBoxes;
            } else {
                totalUnits += truckSize * unitsPerBox;
                truckSize = 0;
                break;
            }
        }

        return totalUnits;
    }
};