class Solution {
    public int minimumEnergy(int[][] tasks) {
        int minEnergy = 0;
        int currentEnergy = 0;

        for (int[] task : tasks) {
            int actualEnergy = task[0];
            int requiredEnergy = task[1];

            currentEnergy -= actualEnergy;
            if (currentEnergy < 0) {
                minEnergy += -currentEnergy;
                currentEnergy = 0;
            }
            currentEnergy += requiredEnergy;
        }

        return minEnergy;
    }
}