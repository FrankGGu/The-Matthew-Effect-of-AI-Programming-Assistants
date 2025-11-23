class Employee:
    def __init__(self, id: int, importance: int, subordinates: list[int]):
        self.id = id
        self.importance = importance
        self.subordinates = subordinates

class Solution:
    def getImportance(self, employees: list[Employee], id: int) -> int:
        employee_map = {employee.id: employee for employee in employees}

        def dfs(employee_id):
            employee = employee_map[employee_id]
            importance = employee.importance
            for subordinate_id in employee.subordinates:
                importance += dfs(subordinate_id)
            return importance

        return dfs(id)