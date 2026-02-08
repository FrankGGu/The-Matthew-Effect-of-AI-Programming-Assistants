class Solution:
    def average(self, salary: list[int]) -> float:
        min_salary = float('inf')
        max_salary = float('-inf')
        total_sum = 0

        for s in salary:
            total_sum += s
            if s < min_salary:
                min_salary = s
            if s > max_salary:
                max_salary = s

        adjusted_sum = total_sum - min_salary - max_salary
        adjusted_count = len(salary) - 2

        return adjusted_sum / adjusted_count