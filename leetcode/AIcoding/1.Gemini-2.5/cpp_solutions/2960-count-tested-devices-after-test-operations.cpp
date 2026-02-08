#include <vector>

class Solution {
public:
    int countTestedDevices(std::vector<int>& batteryPercentages) {
        int testedCount = 0;
        for (int i = 0; i < batteryPercentages.size(); ++i) {
            if (batteryPercentages[i] - testedCount > 0) {
                testedCount++;
            }
        }
        return testedCount;
    }
};