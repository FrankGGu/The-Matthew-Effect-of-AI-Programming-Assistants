class Solution:
    def maximumNodes(self, n: int, edges: List[List[int]], target: int) -> int:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        parent = [0] * (n + 1)
        children = defaultdict(list)
        q = deque([1])
        visited = set([1])

        while q:
            u = q.popleft()
            for v in graph[u]:
                if v not in visited:
                    visited.add(v)
                    parent[v] = u
                    children[u].append(v)
                    q.append(v)

        size = [0] * (n + 1)
        res = 0

        def dfs(u):
            nonlocal res
            total = 1
            for v in children[u]:
                total += dfs(v)
            if total >= target:
                res += 1
                return 0
            return total

        dfs(1)
        return res