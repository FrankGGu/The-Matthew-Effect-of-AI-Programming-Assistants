class Solution:
    def maximumPopulation(self, logs: List[List[int]]) -> int:
        delta = [0] * 101
        offset = 1950
        for birth, death in logs:
            delta[birth - offset] += 1
            delta[death - offset] -= 1

        max_pop = 0
        current_pop = 0
        result_year = 0
        for year in range(101):
            current_pop += delta[year]
            if current_pop > max_pop:
                max_pop = current_pop
                result_year = year + offset
        return result_year