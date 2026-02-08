class Solution {
    public int minNumberOfHours(int initialEnergy, int initialExperience, int[] energy, int[] experience) {
        int hours = 0;
        int currentEnergy = initialEnergy;
        int currentExperience = initialExperience;

        for (int i = 0; i < energy.length; i++) {
            if (currentEnergy <= energy[i]) {
                hours += (energy[i] - currentEnergy + 1);
                currentEnergy = energy[i] + 1;
            }
            currentEnergy -= energy[i];

            if (currentExperience <= experience[i]) {
                hours += (experience[i] - currentExperience + 1);
                currentExperience = experience[i] + 1;
            }
            currentExperience += experience[i];
        }

        return hours;
    }
}