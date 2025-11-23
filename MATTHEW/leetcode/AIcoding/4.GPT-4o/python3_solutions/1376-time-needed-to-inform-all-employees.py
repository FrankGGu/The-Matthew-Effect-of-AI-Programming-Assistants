from collections import deque

def numOfMinutes(n: int, headID: int, manager: List[int], informTime: List[int]) -> int:
    tree = [[] for _ in range(n)]
    for emp in range(n):
        if manager[emp] != -1:
            tree[manager[emp]].append(emp)

    max_time = 0
    queue = deque([(headID, 0)])

    while queue:
        emp, time = queue.popleft()
        max_time = max(max_time, time)
        for sub in tree[emp]:
            queue.append((sub, time + informTime[emp]))

    return max_time