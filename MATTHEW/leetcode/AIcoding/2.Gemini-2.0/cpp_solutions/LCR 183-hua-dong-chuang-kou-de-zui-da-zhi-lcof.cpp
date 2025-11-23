#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int highestAltitude(vector<int>& gain) {
        int currentAltitude = 0;
        int maxAltitude = 0;
        for (int g : gain) {
            currentAltitude += g;
            maxAltitude = max(maxAltitude, currentAltitude);
        }
        return maxAltitude;
    }
};