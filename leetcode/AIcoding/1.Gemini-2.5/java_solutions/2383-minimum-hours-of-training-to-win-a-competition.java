class Solution {
    public int minNumberOfHours(int initialEnergy, int initialExperience, int[] energy, int[] experience) {
        int currentEnergy = initialEnergy;
        int currentExperience = initialExperience;
        int trainingHours = 0;

        for (int i = 0; i < energy.length; i++) {
            // Check energy requirement
            if (currentEnergy <= energy[i]) {
                int neededEnergy = energy[i] - currentEnergy + 1;
                trainingHours += neededEnergy;
                currentEnergy += neededEnergy;
            }

            // Check experience requirement
            if (currentExperience <= experience[i]) {
                int neededExperience = experience[i] - currentExperience + 1;
                trainingHours += neededExperience;
                currentExperience += neededExperience;
            }

            // After defeating the opponent, update current stats
            currentEnergy -= energy[i];
            currentExperience += experience[i];
        }

        return trainingHours;
    }
}