class Solution:
    def minimumTimeRequired(self, jobs: List[int], k: int) -> int:
        workers = [0] * k
        self.res = float('inf')
        jobs.sort(reverse=True)

        def dfs(idx):
            if idx == len(jobs):
                self.res = min(self.res, max(workers))
                return
            for i in range(k):
                if workers[i] + jobs[idx] >= self.res:
                    continue
                workers[i] += jobs[idx]
                dfs(idx + 1)
                workers[i] -= jobs[idx]
                if workers[i] == 0:
                    break
        dfs(0)
        return self.res