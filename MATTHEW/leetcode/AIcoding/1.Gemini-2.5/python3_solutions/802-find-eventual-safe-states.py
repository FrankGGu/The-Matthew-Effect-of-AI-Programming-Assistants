class Solution:
    def eventualSafeStates(self, graph: list[list[int]]) -> list[int]:
        n = len(graph)

        # 0: unvisited
        # 1: visiting (currently in recursion stack)
        # 2: safe (all paths from this node lead to terminal nodes)
        # 3: unsafe (leads to a cycle or another unsafe node)
        colors = [0] * n

        def is_safe(u: int) -> bool:
            if colors[u] == 1:  # Node is currently being visited, means a cycle is detected
                colors[u] = 3  # Mark as unsafe
                return False
            if colors[u] == 2:  # Node is already determined safe
                return True
            if colors[u] == 3:  # Node is already determined unsafe
                return False

            colors[u] = 1  # Mark as visiting

            for v in graph[u]:
                if not is_safe(v):
                    colors[u] = 3  # If any neighbor leads to an unsafe path, u is unsafe
                    return False

            colors[u] = 2  # All neighbors lead to safe paths, so u is safe
            return True

        safe_nodes = []
        for i in range(n):
            if is_safe(i):
                safe_nodes.append(i)

        return safe_nodes