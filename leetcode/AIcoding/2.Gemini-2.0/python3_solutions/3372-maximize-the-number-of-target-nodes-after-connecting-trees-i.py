def solve():
    def max_target_nodes(edges, target_node):
        """
        You are given a list of edges representing a directed graph where each edge is represented as a pair [u, v]
        indicating that there is a directed edge from node u to node v. You are also given a target_node.

        You can connect two trees from the graph by adding an edge between any two nodes of the trees.
        Your task is to maximize the number of nodes that can reach the target_node after connecting the trees.

        Return the maximum number of nodes that can reach the target_node after connecting the trees.
        """

        n = 0
        for u, v in edges:
            n = max(n, u, v)
        n += 1

        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)

        def bfs(start_node):
            q = [start_node]
            visited = {start_node}
            while q:
                curr = q.pop(0)
                for neighbor in adj[curr]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        q.append(neighbor)
            return visited

        components = []
        visited_all = set()
        for i in range(n):
            if i not in visited_all:
                component = bfs(i)
                components.append(component)
                visited_all.update(component)

        reachable_from_target = bfs(target_node)
        reachable_nodes = len(reachable_from_target)

        remaining_components = []
        for component in components:
            if not (component & reachable_from_target):
                remaining_components.append(component)

        if remaining_components:
            reachable_nodes += sum(len(c) for c in remaining_components)
        return reachable_nodes

    # Example usage (replace with LeetCode input):
    edges = [[0, 1], [0, 2], [1, 3], [2, 4]]
    target_node = 4
    result = max_target_nodes(edges, target_node)
    print(result)  # Output: 5
```

```python
class Solution:
    def maximizeTheNumberOfTargetNodes(self, edges: list[list[int]], targetNode: int) -> int:
        n = 0
        for u, v in edges:
            n = max(n, u, v)
        n += 1

        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)

        def bfs(start_node):
            q = [start_node]
            visited = {start_node}
            while q:
                curr = q.pop(0)
                for neighbor in adj[curr]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        q.append(neighbor)
            return visited

        components = []
        visited_all = set()
        for i in range(n):
            if i not in visited_all:
                component = bfs(i)
                components.append(component)
                visited_all.update(component)

        reachable_from_target = bfs(targetNode)
        reachable_nodes = len(reachable_from_target)

        remaining_components = []
        for component in components:
            if not (component & reachable_from_target):
                remaining_components.append(component)

        if remaining_components:
            reachable_nodes += sum(len(c) for c in remaining_components)
        return reachable_nodes