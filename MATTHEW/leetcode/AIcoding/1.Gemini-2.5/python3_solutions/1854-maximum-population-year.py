class Solution:
    def maximumPopulation(self, logs: list[list[int]]) -> int:
        # The problem constraints state 1950 <= birth < death <= 2050.
        # This means the relevant years for population are from 1950 to 2049.
        # We can use an array to store population changes for each year.
        # The array index can be mapped to a year by subtracting the base year (1950).

        min_year = 1950
        max_year = 2050 # This is the max 'death' year, so we need to consider up to this year for population changes.

        # Create an array to store population changes.
        # Size: (max_year - min_year + 1) to cover all years from min_year to max_year.
        # Index i corresponds to year (min_year + i).
        population_changes = [0] * (max_year - min_year + 1)

        for birth, death in logs:
            # Increment population at birth year
            population_changes[birth - min_year] += 1
            # Decrement population at death year
            # A person is alive UP TO (but not including) their death year.
            # So, the population decreases starting from the death year.
            population_changes[death - min_year] -= 1

        current_population = 0
        max_population = 0
        max_population_year = min_year # Initialize with the earliest possible year

        # Iterate through the population changes array to find the year with maximum population.
        # The loop runs from index 0 up to (max_year - min_year).
        for i in range(len(population_changes)):
            current_population += population_changes[i]

            # If the current population is greater than the maximum population found so far,
            # update max_population and max_population_year.
            # Since we iterate years in increasing order, the first year found with max population
            # will be the earliest one.
            if current_population > max_population:
                max_population = current_population
                max_population_year = min_year + i

        return max_population_year