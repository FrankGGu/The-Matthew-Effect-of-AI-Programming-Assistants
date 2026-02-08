#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    int garbageCollection(std::vector<std::string>& garbage, std::vector<int>& travel) {
        int totalTime = 0;
        int lastM = 0;
        int lastP = 0;
        int lastG = 0;

        for (int i = 0; i < garbage.size(); ++i) {
            totalTime += garbage[i].length();
            if (garbage[i].find('M') != std::string::npos) {
                lastM = i;
            }
            if (garbage[i].find('P') != std::string::npos) {
                lastP = i;
            }
            if (garbage[i].find('G') != std::string::npos) {
                lastG = i;
            }
        }

        std::vector<int> prefixTravel(travel.size() + 1, 0);
        for (int i = 0; i < travel.size(); ++i) {
            prefixTravel[i + 1] = prefixTravel[i] + travel[i];
        }

        totalTime += (lastM > 0) ? prefixTravel[lastM] : 0;
        totalTime += (lastP > 0) ? prefixTravel[lastP] : 0;
        totalTime += (lastG > 0) ? prefixTravel[lastG] : 0;

        return totalTime;
    }
};