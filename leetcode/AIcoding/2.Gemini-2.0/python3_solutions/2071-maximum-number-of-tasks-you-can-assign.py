class Solution:
    def maxTaskAssign(self, tasks: List[int], workers: List[int], pills: int, strength: int) -> int:
        tasks.sort()
        workers.sort()

        def check(k):
            curr_pills = pills
            worker_idx = len(workers) - 1

            for task_idx in range(k - 1, -1, -1):
                while worker_idx >= 0 and workers[worker_idx] < tasks[task_idx]:
                    worker_idx -= 1

                if worker_idx >= 0:
                    worker_idx -= 1
                else:
                    curr_pills -= 1
                    if curr_pills < 0:
                        return False

                    worker_idx = len(workers) - 1
                    while worker_idx >= 0 and workers[worker_idx] + strength < tasks[task_idx]:
                        worker_idx -= 1

                    if worker_idx >= 0:
                        worker_idx -= 1
                    else:
                        return False
            return True

        left, right = 0, len(tasks)
        ans = 0
        while left <= right:
            mid = (left + right) // 2
            if check(mid):
                ans = mid
                left = mid + 1
            else:
                right = mid - 1
        return ans