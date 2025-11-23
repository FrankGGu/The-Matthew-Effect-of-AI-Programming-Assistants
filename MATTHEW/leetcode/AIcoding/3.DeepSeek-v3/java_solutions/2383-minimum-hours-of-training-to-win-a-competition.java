class Solution {
    public int minNumberOfHours(int initialEnergy, int initialExperience, int[] energy, int[] experience) {
        int totalEnergy = 0;
        for (int e : energy) {
            totalEnergy += e;
        }
        int requiredEnergy = Math.max(0, totalEnergy - initialEnergy + 1);

        int requiredExperience = 0;
        int currentExp = initialExperience;
        for (int exp : experience) {
            if (currentExp <= exp) {
                int needed = exp - currentExp + 1;
                requiredExperience += needed;
                currentExp += needed;
            }
            currentExp += exp;
        }

        return requiredEnergy + requiredExperience;
    }
}