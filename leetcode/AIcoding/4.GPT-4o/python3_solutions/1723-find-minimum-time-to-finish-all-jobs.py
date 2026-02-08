from typing import List
import itertools

class Solution:
    def minimumTimeRequired(self, jobs: List[int], k: int) -> int:
        def canFinish(maxTime):
            workers = [0] * k
            return self.assignJobs(jobs, workers, 0, maxTime)

        def assignJobs(jobs, workers, index, maxTime):
            if index == len(jobs):
                return True
            for i in range(k):
                if workers[i] + jobs[index] <= maxTime:
                    workers[i] += jobs[index]
                    if assignJobs(jobs, workers, index + 1, maxTime):
                        return True
                    workers[i] -= jobs[index]
                if workers[i] == 0:  # If this worker is still free, no need to try others
                    break
            return False

        left, right = max(jobs), sum(jobs)
        while left < right:
            mid = (left + right) // 2
            if canFinish(mid):
                right = mid
            else:
                left = mid + 1
        return left