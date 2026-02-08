class Solution {
public:
    int minNumberOfHours(int initialEnergy, int initialExperience, vector<int>& energy, vector<int>& experience) {
        int totalEnergy = 0, totalExperience = 0;

        for (int e : energy) {
            totalEnergy += e;
        }

        for (int exp : experience) {
            totalExperience += exp;
        }

        int requiredEnergy = totalEnergy + 1 - initialEnergy;
        int requiredExperience = 0;
        int currentExperience = initialExperience;

        for (int exp : experience) {
            if (currentExperience <= exp) {
                requiredExperience += exp + 1 - currentExperience;
                currentExperience = exp + 1;
            }
            currentExperience += exp;
        }

        return max(0, requiredEnergy) + requiredExperience;
    }
};