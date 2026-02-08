class Solution:
    def longestCycle(self, edges: List[int]) -> int:
        n = len(edges)
        visited = [False] * n
        on_stack = [False] * n
        index = 0
        longest = -1
        indices = [-1] * n

        def dfs(node):
            nonlocal index, longest
            if visited[node]:
                if on_stack[node]:
                    cycle_length = index - indices[node]
                    longest = max(longest, cycle_length)
                return

            visited[node] = True
            on_stack[node] = True
            indices[node] = index
            index += 1

            if edges[node] != -1:
                dfs(edges[node])

            on_stack[node] = False

        for i in range(n):
            if not visited[i]:
                dfs(i)

        return longest