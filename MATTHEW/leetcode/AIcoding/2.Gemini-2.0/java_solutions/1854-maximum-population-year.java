class Solution {
    public int maximumPopulation(int[][] logs) {
        int[] years = new int[101];
        for (int[] log : logs) {
            years[log[0] - 1950]++;
            years[log[1] - 1950]--;
        }
        int maxPopulation = 0;
        int maxYear = 1950;
        int currentPopulation = 0;
        for (int i = 0; i < 101; i++) {
            currentPopulation += years[i];
            if (currentPopulation > maxPopulation) {
                maxPopulation = currentPopulation;
                maxYear = 1950 + i;
            }
        }
        return maxYear;
    }
}