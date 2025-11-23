class Solution:
    def average(self, salary: list[int]) -> float:
        min_salary = min(salary)
        max_salary = max(salary)
        total_salary = sum(salary) - min_salary - max_salary
        return total_salary / (len(salary) - 2)