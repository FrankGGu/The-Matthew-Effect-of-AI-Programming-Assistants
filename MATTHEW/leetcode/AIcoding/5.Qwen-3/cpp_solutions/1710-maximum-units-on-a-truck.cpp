#include <iostream>
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
        for (const auto& box : boxTypes) {
            int numBoxes = box[0];
            int unitsPerBox = box[1];
            if (truckSize <= 0) break;
            int take = min(numBoxes, truckSize);
            totalUnits += take * unitsPerBox;
            truckSize -= take;
        }
        return totalUnits;
    }
};