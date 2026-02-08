#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minNumberOfLevels(int energy, vector<int>& experience) {
        int n = experience.size();
        int levels = 0;
        int currentExperience = 0;
        for (int i = 0; i < n; ++i) {
            if (energy <= experience[i]) {
                energy++;
                levels++;
            }
            energy -= experience[i];
            currentExperience += experience[i];
        }
        return levels;
    }
};