#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minNumberofHours(int initialEnergy, int initialExperience, vector<int>& energy, vector<int>& experience) {
        int n = energy.size();
        int hours = 0;
        int currentEnergy = initialEnergy;
        int currentExperience = initialExperience;

        for (int i = 0; i < n; ++i) {
            if (currentEnergy <= energy[i]) {
                hours += (energy[i] - currentEnergy + 1);
                currentEnergy = energy[i] + 1;
            }

            if (currentExperience <= experience[i]) {
                hours += (experience[i] - currentExperience + 1);
                currentExperience = experience[i] + 1;
            }

            currentEnergy -= energy[i];
            currentExperience += experience[i];
        }

        return hours;
    }
};