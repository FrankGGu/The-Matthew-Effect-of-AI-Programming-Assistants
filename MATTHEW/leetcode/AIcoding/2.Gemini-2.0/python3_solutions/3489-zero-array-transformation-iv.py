class Solution:
    def solve(self, nums: list[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0

        adj = [[] for _ in range(n)]
        for i in range(n):
            if nums[i] != 0:
                for j in range(n):
                    if nums[j] == 0:
                        adj[i].append(j)

        q = []
        visited = [False] * n

        for i in range(n):
            if nums[i] != 0 and not visited[i]:
                q.append(i)
                visited[i] = True

        cycles = 0
        while q:
            u = q.pop(0)

            for v in adj[u]:
                if nums[v] != 0:
                    continue

                cycles += 1
                nums[u] = 0
                break

        remaining_non_zeros = sum(1 for num in nums if num != 0)

        return cycles + remaining_non_zeros