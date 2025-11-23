class Solution:
    def isBipartite(self, graph: List[List[int]]) -> bool:
        color = {}
        for node in range(len(graph)):
            if node not in color:
                stack = [node]
                color[node] = 0
                while stack:
                    current = stack.pop()
                    for neighbor in graph[current]:
                        if neighbor not in color:
                            color[neighbor] = color[current] ^ 1
                            stack.append(neighbor)
                        elif color[neighbor] == color[current]:
                            return False
        return True