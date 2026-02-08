class Solution:
    def minimumTimeRequired(self, jobs: list[int], k: int) -> int:
        n = len(jobs)
        jobs.sort(reverse=True)
        workers = [0] * k

        def backtrack(idx):
            if idx == n:
                return max(workers)

            min_time = float('inf')
            used = set()
            for i in range(k):
                if workers[i] in used:
                    continue
                used.add(workers[i])

                workers[i] += jobs[idx]
                min_time = min(min_time, backtrack(idx + 1))
                workers[i] -= jobs[idx]

            return min_time

        return backtrack(0)