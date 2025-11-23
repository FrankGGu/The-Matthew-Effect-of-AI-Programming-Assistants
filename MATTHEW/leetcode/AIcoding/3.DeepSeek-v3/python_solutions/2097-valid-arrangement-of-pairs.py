from collections import defaultdict

class Solution:
    def validArrangement(self, pairs: List[List[int]]) -> List[List[int]]:
        graph = defaultdict(list)
        in_degree = defaultdict(int)
        out_degree = defaultdict(int)

        for u, v in pairs:
            graph[u].append(v)
            out_degree[u] += 1
            in_degree[v] += 1

        start = pairs[0][0]
        for u in out_degree:
            if out_degree[u] - in_degree[u] == 1:
                start = u
                break

        path = []
        stack = [start]
        while stack:
            current = stack[-1]
            if graph[current]:
                next_node = graph[current].pop()
                stack.append(next_node)
            else:
                path.append(stack.pop())

        path.reverse()
        result = []
        for i in range(len(path)-1):
            result.append([path[i], path[i+1]])

        return result