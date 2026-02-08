from collections import defaultdict, deque

class Solution:
    def numBusesToDestination(self, routes: List[List[int]], source: int, target: int) -> int:
        if source == target:
            return 0

        graph = defaultdict(set)
        for i, route in enumerate(routes):
            for stop in route:
                graph[stop].add(i)

        queue = deque([source])
        visited_stops = {source}
        visited_routes = set()
        buses = 0

        while queue:
            buses += 1
            for _ in range(len(queue)):
                stop = queue.popleft()
                for route_index in graph[stop]:
                    if route_index in visited_routes:
                        continue
                    visited_routes.add(route_index)
                    for next_stop in routes[route_index]:
                        if next_stop == target:
                            return buses
                        if next_stop not in visited_stops:
                            visited_stops.add(next_stop)
                            queue.append(next_stop)

        return -1