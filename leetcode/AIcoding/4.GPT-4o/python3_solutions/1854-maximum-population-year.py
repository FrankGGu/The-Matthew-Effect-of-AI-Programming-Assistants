class Solution:
    def maximumPopulation(self, logs: List[List[int]]) -> int:
        year_population = [0] * 2051
        for birth, death in logs:
            year_population[birth] += 1
            year_population[death] -= 1

        max_population = 0
        max_year = 0
        current_population = 0

        for year in range(1950, 2051):
            current_population += year_population[year]
            if current_population > max_population:
                max_population = current_population
                max_year = year

        return max_year