class Solution:
    def processTasks(self, tasks: List[int], n: int) -> List[int]:
        from collections import deque
        task_count = [0] * 26
        for task in tasks:
            task_count[task] += 1

        task_queue = deque([i for i in range(26) if task_count[i] > 0])
        result = []
        while task_queue:
            temp = []
            for _ in range(n + 1):
                if task_queue:
                    task = task_queue.popleft()
                    result.append(task)
                    task_count[task] -= 1
                    if task_count[task] > 0:
                        temp.append(task)
            task_queue.extend(temp)
            if temp:
                result.extend([-1] * (n + 1 - len(temp)))

        return result