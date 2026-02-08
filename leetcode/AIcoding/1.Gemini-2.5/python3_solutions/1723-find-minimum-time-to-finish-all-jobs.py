import collections

class Solution:
    def minimumTimeRequired(self, jobs: list[int], k: int) -> int:
        n = len(jobs)

        # Sort jobs in descending order for better pruning in backtracking
        jobs.sort(reverse=True)

        # Binary search for the minimum maximum time
        low = max(jobs)
        high = sum(jobs)
        ans = high

        def check(time_limit: int) -> bool:
            """
            Checks if it's possible to finish all jobs such that no worker
            exceeds time_limit, using k workers.
            """
            worker_loads = [0] * k

            def can_assign(job_idx: int) -> bool:
                if job_idx == n:
                    return True

                current_job = jobs[job_idx]

                for w in range(k):
                    # Try to assign current_job to worker w
                    if worker_loads[w] + current_job <= time_limit:
                        worker_loads[w] += current_job
                        if can_assign(job_idx + 1):
                            return True
                        worker_loads[w] -= current_job  # Backtrack

                    # Pruning for identical workers:
                    # If this worker (w) was empty (load 0) before trying current_job,
                    # and assigning current_job to it (or subsequent assignments) failed,
                    # then trying current_job to any other worker that is also currently empty
                    # will lead to a symmetric state and also fail.
                    # So, we can stop trying other workers for this job.
                    if worker_loads[w] == 0:
                        break

                return False

            return can_assign(0)

        while low <= high:
            mid = (low + high) // 2
            if check(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans