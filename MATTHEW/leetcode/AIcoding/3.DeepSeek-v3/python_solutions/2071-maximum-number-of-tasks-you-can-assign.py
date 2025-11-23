import bisect

class Solution:
    def maxTaskAssign(self, tasks: List[int], workers: List[int], pills: int, strength: int) -> int:
        tasks.sort()
        workers.sort()

        left, right = 0, min(len(tasks), len(workers))
        answer = 0

        def is_possible(k):
            temp_pills = pills
            worker_ptr = len(workers) - k
            task_ptr = 0
            temp_workers = workers[worker_ptr:worker_ptr + k]
            temp_tasks = tasks[:k]

            for task in temp_tasks:
                if temp_workers and temp_workers[-1] >= task:
                    temp_workers.pop()
                else:
                    if temp_pills == 0:
                        return False
                    idx = bisect.bisect_left(temp_workers, task - strength)
                    if idx >= len(temp_workers):
                        return False
                    temp_workers.pop(idx)
                    temp_pills -= 1
            return True

        while left <= right:
            mid = (left + right) // 2
            if is_possible(mid):
                answer = mid
                left = mid + 1
            else:
                right = mid - 1
        return answer