class Solution {
public:
    int maximumUnits(vector<vector<int>>& boxTypes, int truckSize) {
        sort(boxTypes.begin(), boxTypes.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] > b[1];
        });

        int totalUnits = 0;
        for (const auto& box : boxTypes) {
            int numBoxes = min(box[0], truckSize);
            totalUnits += numBoxes * box[1];
            truckSize -= numBoxes;
            if (truckSize == 0) break;
        }
        return totalUnits;
    }
};