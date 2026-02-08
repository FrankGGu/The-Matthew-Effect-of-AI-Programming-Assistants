class Solution {
    public int maximumPopulation(int[][] logs) {
        int[] populationChanges = new int[2051]; // Array to store population changes for years 0 to 2050

        // Populate the populationChanges array based on birth and death years
        for (int[] log : logs) {
            int birthYear = log[0];
            int deathYear = log[1];
            populationChanges[birthYear]++; // Person is born, population increases
            populationChanges[deathYear]--; // Person dies, population decreases starting from this year
        }

        int currentPopulation = 0;
        int maxPopulation = 0;
        int maxPopulationYear = 1950; // Initialize with the earliest possible year

        // Calculate the running population for each year and find the year with maximum population
        // The problem constraints state years are between 1950 and 2050.
        for (int year = 1950; year <= 2050; year++) {
            currentPopulation += populationChanges[year];

            // If the current population is greater than the maximum found so far, update.
            // If populations are equal, we want the earliest year, so only update on strictly greater.
            if (currentPopulation > maxPopulation) {
                maxPopulation = currentPopulation;
                maxPopulationYear = year;
            }
        }

        return maxPopulationYear;
    }
}