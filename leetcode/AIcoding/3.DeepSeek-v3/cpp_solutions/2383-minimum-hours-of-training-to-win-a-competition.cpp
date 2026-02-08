class Solution {
public:
    int minNumberOfHours(int initialEnergy, int initialExperience, vector<int>& energy, vector<int>& experience) {
        int totalEnergy = 0;
        for (int e : energy) {
            totalEnergy += e;
        }
        int requiredEnergy = max(0, totalEnergy - initialEnergy + 1);

        int requiredExp = 0;
        int currentExp = initialExperience;
        for (int exp : experience) {
            if (currentExp <= exp) {
                int needed = exp - currentExp + 1;
                requiredExp += needed;
                currentExp += needed;
            }
            currentExp += exp;
        }

        return requiredEnergy + requiredExp;
    }
};