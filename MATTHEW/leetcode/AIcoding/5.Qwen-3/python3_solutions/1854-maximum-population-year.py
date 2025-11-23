class Solution:
    def maximumPopulation(self, logs: List[List[int]]) -> int:
        diff = [0] * 101
        for birth, death in logs:
            diff[birth - 1950] += 1
            diff[death - 1950] -= 1
        max_pop = 0
        current_pop = 0
        result_year = 0
        for i in range(101):
            current_pop += diff[i]
            if current_pop > max_pop:
                max_pop = current_pop
                result_year = i + 1950
        return result_year