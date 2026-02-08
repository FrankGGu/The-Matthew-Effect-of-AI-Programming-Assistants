class Solution:
    def maximumPopulation(self, logs: List[List[int]]) -> int:
        years = [0] * 101
        for birth, death in logs:
            years[birth - 1950] += 1
            years[death - 1950] -= 1

        max_population = 0
        max_year = 1950
        current_population = 0

        for i in range(101):
            current_population += years[i]
            if current_population > max_population:
                max_population = current_population
                max_year = 1950 + i

        return max_year