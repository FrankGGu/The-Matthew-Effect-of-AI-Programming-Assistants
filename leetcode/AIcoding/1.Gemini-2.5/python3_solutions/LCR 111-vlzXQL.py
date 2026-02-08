from collections import defaultdict, deque

class Solution:
    def calcEquation(self, equations: list[list[str]], values: list[float], queries: list[list[str]]) -> list[float]:
        graph = defaultdict(dict)

        for i in range(len(equations)):
            numerator, denominator = equations[i]
            value = values[i]
            graph[numerator][denominator] = value
            graph[denominator][numerator] = 1.0 / value

        results = []

        for query_numerator, query_denominator in queries:
            if query_numerator not in graph or query_denominator not in graph:
                results.append(-1.0)
                continue

            if query_numerator == query_denominator:
                results.append(1.0)
                continue

            queue = deque([(query_numerator, 1.0)])
            visited = {query_numerator}
            found = False

            while queue:
                current_node, current_product = queue.popleft()

                if current_node == query_denominator:
                    results.append(current_product)
                    found = True
                    break

                for neighbor, weight in graph[current_node].items():
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append((neighbor, current_product * weight))

            if not found:
                results.append(-1.0)

        return results