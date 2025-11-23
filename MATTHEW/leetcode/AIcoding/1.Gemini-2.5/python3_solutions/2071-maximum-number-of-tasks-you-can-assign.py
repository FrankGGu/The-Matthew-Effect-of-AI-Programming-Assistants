import collections
import heapq

class Solution:
    def maxTasks(self, tasks: list[int], workers: list[int], pills: int, strength: int) -> int:
        tasks.sort()
        workers.sort()

        def check(k: int) -> bool:
            if k == 0:
                return True

            pills_left = pills
            worker_ptr = 0

            available_workers_for_tasks = [] # Min-heap to store workers that are strong enough
                                             # (with or without a pill) for the current or future tasks.

            for task_idx in range(k):
                current_task_difficulty = tasks[task_idx]

                # Add all workers whose (strength + pill_strength) is sufficient for the current task
                # to the min-heap. We iterate through `workers` using `worker_ptr`, adding workers
                # that can potentially complete `current_task_difficulty` (even with a pill).
                while worker_ptr < len(workers) and workers[worker_ptr] + strength >= current_task_difficulty:
                    heapq.heappush(available_workers_for_tasks, workers[worker_ptr])
                    worker_ptr += 1

                # If no worker in the heap can do the current task (even with a pill),
                # then `k` tasks are not possible.
                if not available_workers_for_tasks:
                    return False

                # Try to assign the current task to the weakest available worker.
                weakest_worker_strength = heapq.heappop(available_workers_for_tasks)

                # If the weakest worker can do the task without a pill, great.
                if weakest_worker_strength >= current_task_difficulty:
                    # No pill needed.
                    pass
                # If the weakest worker needs a pill and we have pills left.
                elif pills_left > 0:
                    pills_left -= 1
                # If the weakest worker needs a pill but we have no pills left.
                else:
                    return False

            return True

        low = 0
        high = min(len(tasks), len(workers))
        ans = 0

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans