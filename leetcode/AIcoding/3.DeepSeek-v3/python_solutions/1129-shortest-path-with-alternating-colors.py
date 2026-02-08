from collections import deque

class Solution:
    def shortestAlternatingPaths(self, n: int, redEdges: List[List[int]], blueEdges: List[List[int]]) -> List[int]:
        red_graph = [[] for _ in range(n)]
        blue_graph = [[] for _ in range(n)]

        for u, v in redEdges:
            red_graph[u].append(v)
        for u, v in blueEdges:
            blue_graph[u].append(v)

        res = [-1] * n
        res[0] = 0

        q = deque()
        q.append((0, 'r'))
        q.append((0, 'b'))

        visited_red = [False] * n
        visited_blue = [False] * n
        visited_red[0] = True
        visited_blue[0] = True

        steps = 0

        while q:
            steps += 1
            for _ in range(len(q)):
                node, color = q.popleft()
                if color == 'r':
                    for neighbor in blue_graph[node]:
                        if not visited_blue[neighbor]:
                            if res[neighbor] == -1 or steps < res[neighbor]:
                                res[neighbor] = steps
                            visited_blue[neighbor] = True
                            q.append((neighbor, 'b'))
                else:
                    for neighbor in red_graph[node]:
                        if not visited_red[neighbor]:
                            if res[neighbor] == -1 or steps < res[neighbor]:
                                res[neighbor] = steps
                            visited_red[neighbor] = True
                            q.append((neighbor, 'r'))

        return res