import collections

class Solution:
    def numOfMinutes(self, n: int, headID: int, manager: list[int], informTime: list[int]) -> int:
        adj = collections.defaultdict(list)
        for i in range(n):
            if manager[i] != -1:
                adj[manager[i]].append(i)

        def dfs(employee_id):
            max_time_for_reports = 0
            for report in adj[employee_id]:
                max_time_for_reports = max(max_time_for_reports, dfs(report))

            return informTime[employee_id] + max_time_for_reports

        return dfs(headID)