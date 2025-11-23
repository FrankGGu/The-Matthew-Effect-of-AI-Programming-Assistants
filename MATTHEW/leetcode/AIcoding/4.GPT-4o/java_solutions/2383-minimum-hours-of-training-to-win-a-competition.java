class Solution {
    public int minNumberOfHours(int initialEnergy, int initialExperience, int[] energy, int[] experience) {
        int totalHours = 0;
        int requiredEnergy = 0;
        int requiredExperience = 0;

        for (int i = 0; i < energy.length; i++) {
            if (initialEnergy <= energy[i]) {
                requiredEnergy += energy[i] - initialEnergy + 1;
                initialEnergy = energy[i] + 1;
            }
            initialEnergy -= energy[i];

            if (initialExperience <= experience[i]) {
                requiredExperience += experience[i] - initialExperience + 1;
                initialExperience = experience[i] + 1;
            }
            initialExperience += experience[i];
        }

        return requiredEnergy + requiredExperience;
    }
}