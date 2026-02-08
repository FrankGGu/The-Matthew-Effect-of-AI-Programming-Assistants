class Solution:
    def componentValue(self, nums: List[int], edges: List[List[int]]) -> int:
        total = sum(nums)
        n = len(nums)
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        def dfs(u, parent, target):
            current = nums[u]
            for v in graph[u]:
                if v == parent:
                    continue
                res = dfs(v, u, target)
                if res == -1:
                    return -1
                current += res
            if current > target:
                return -1
            return current % target

        max_k = 0
        for k in range(1, int(total ** 0.5) + 1):
            if total % k == 0:
                for candidate in [k, total // k]:
                    if candidate < total and dfs(0, -1, candidate) == 0:
                        max_k = max(max_k, total // candidate - 1)
        return max_k