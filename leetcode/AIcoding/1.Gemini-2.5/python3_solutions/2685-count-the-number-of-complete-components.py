import collections

class Solution:
    def countCompleteComponents(self, n: int, edges: list[list[int]]) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        visited = [False] * n
        complete_components_count = 0

        for i in range(n):
            if not visited[i]:
                q = collections.deque([i])
                visited[i] = True

                current_component_nodes = []
                current_component_nodes_set = set()

                current_component_nodes.append(i)
                current_component_nodes_set.add(i)

                while q:
                    u = q.popleft()

                    for v in adj[u]:
                        if not visited[v]:
                            visited[v] = True
                            q.append(v)
                            current_component_nodes.append(v)
                            current_component_nodes_set.add(v)

                V_c = len(current_component_nodes)
                is_complete = True

                for node in current_component_nodes:
                    degree_in_component = 0
                    for neighbor in adj[node]:
                        if neighbor in current_component_nodes_set:
                            degree_in_component += 1

                    if degree_in_component != V_c - 1:
                        is_complete = False
                        break

                if is_complete:
                    complete_components_count += 1

        return complete_components_count