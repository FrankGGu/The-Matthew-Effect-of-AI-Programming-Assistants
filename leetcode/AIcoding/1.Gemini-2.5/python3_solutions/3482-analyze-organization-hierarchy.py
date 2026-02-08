import collections

class Solution:
    def analyzeOrganizationHierarchy(self, employees: list[list[int]]) -> list[list[int]]:
        if not employees:
            return []

        graph = collections.defaultdict(list)
        all_employee_ids = set()
        roots = []

        for emp_id, _, mgr_id, _ in employees:
            all_employee_ids.add(emp_id)
            if mgr_id is not None:
                graph[mgr_id].append(emp_id)
            else:
                roots.append(emp_id)

        subordinates_memo = {}

        def dfs_subordinates(employee_id):
            if employee_id in subordinates_memo:
                return subordinates_memo[employee_id]

            count = 0
            if employee_id in graph:
                for report_id in graph[employee_id]:
                    count += (1 + dfs_subordinates(report_id))

            subordinates_memo[employee_id] = count
            return count

        for emp_id in all_employee_ids:
            dfs_subordinates(emp_id)

        levels = {}
        queue = collections.deque()

        for root_id in roots:
            levels[root_id] = 0
            queue.append(root_id)

        while queue:
            current_emp_id = queue.popleft()

            if current_emp_id in graph:
                for report_id in graph[current_emp_id]:
                    if report_id not in levels:
                        levels[report_id] = levels[current_emp_id] + 1
                        queue.append(report_id)

        result = []
        for emp_id in sorted(list(all_employee_ids)):
            sub_count = subordinates_memo.get(emp_id, 0)
            level = levels.get(emp_id, -1) 
            result.append([emp_id, sub_count, level])

        return result