class Solution {
    public int maximumPopulation(int[][] logs) {
        int[] populationChange = new int[2051];
        for (int[] log : logs) {
            populationChange[log[0]]++;
            populationChange[log[1]]--;
        }
        int maxPopulation = 0, year = 0, currentPopulation = 0;
        for (int i = 1950; i <= 2050; i++) {
            currentPopulation += populationChange[i];
            if (currentPopulation > maxPopulation) {
                maxPopulation = currentPopulation;
                year = i;
            }
        }
        return year;
    }
}