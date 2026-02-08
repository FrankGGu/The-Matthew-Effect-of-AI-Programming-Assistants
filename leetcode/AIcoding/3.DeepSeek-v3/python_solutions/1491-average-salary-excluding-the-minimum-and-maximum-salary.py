class Solution:
    def average(self, salary: List[int]) -> float:
        min_salary = min(salary)
        max_salary = max(salary)
        total = sum(salary) - min_salary - max_salary
        return total / (len(salary) - 2)