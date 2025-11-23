class Solution:
    def calcEquation(self, equations: List[List[str]], values: List[float], queries: List[List[str]]) -> List[float]:
        graph = {}

        def build_graph(equations, values):
            for (dividend, divisor), value in zip(equations, values):
                if dividend not in graph:
                    graph[dividend] = {}
                graph[dividend][divisor] = value
                if divisor not in graph:
                    graph[divisor] = {}
                graph[divisor][dividend] = 1 / value

        def find_path(query):
            start, end = query
            if start not in graph or end not in graph:
                return -1.0
            queue = [(start, 1.0)]
            visited = set()
            while queue:
                node, current_product = queue.pop(0)
                if node == end:
                    return current_product
                visited.add(node)
                for neighbor, value in graph[node].items():
                    if neighbor not in visited:
                        queue.append((neighbor, current_product * value))
            return -1.0

        build_graph(equations, values)
        return [find_path(query) for query in queries]