class Employee:
    def __init__(self, id: int, importance: int, subordinates: list[int]):
        self.id = id
        self.importance = importance
        self.subordinates = subordinates

class Solution:
    def getImportance(self, employees: list['Employee'], id: int) -> int:
        employee_map = {emp.id: emp for emp in employees}

        total_importance = 0

        def dfs(employee_id: int):
            nonlocal total_importance

            employee = employee_map[employee_id]
            total_importance += employee.importance

            for sub_id in employee.subordinates:
                dfs(sub_id)

        dfs(id)
        return total_importance