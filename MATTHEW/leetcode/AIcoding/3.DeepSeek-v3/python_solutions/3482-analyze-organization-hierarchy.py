class Solution:
    def analyzeHierarchy(self, employees: List[List[int]]) -> List[int]:
        from collections import defaultdict, deque

        if not employees:
            return []

        # Build the tree and find the root
        tree = defaultdict(list)
        in_degree = defaultdict(int)
        all_employees = set()

        for emp in employees:
            eid, manager_id = emp
            all_employees.add(eid)
            if manager_id != -1:
                tree[manager_id].append(eid)
                in_degree[eid] += 1

        # Find root (manager_id is -1)
        root = None
        for emp in employees:
            if emp[1] == -1:
                root = emp[0]
                break

        # BFS to calculate levels
        level = {}
        q = deque()
        q.append(root)
        level[root] = 0

        while q:
            current = q.popleft()
            for subordinate in tree[current]:
                level[subordinate] = level[current] + 1
                q.append(subordinate)

        # Calculate max_level and count of employees at each level
        max_level = max(level.values()) if level else 0
        level_counts = [0] * (max_level + 1)

        for lvl in level.values():
            level_counts[lvl] += 1

        # Calculate total reports for each employee
        reports = defaultdict(int)

        def dfs(node):
            total = 0
            for child in tree[node]:
                total += 1 + dfs(child)
            reports[node] = total
            return total

        dfs(root)

        # Prepare the result
        result = []
        for emp in sorted(all_employees):
            emp_level = level.get(emp, 0)
            emp_reports = reports.get(emp, 0)
            result.extend([emp_level, emp_reports])

        return result