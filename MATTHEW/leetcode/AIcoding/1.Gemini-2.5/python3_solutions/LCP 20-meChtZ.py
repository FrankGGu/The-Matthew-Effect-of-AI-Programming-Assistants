import collections

class Solution:
    def numBusesToDestination(self, routes: List[List[int]], source: int, target: int) -> int:
        if source == target:
            return 0

        stop_to_routes = collections.defaultdict(set)
        for i, route in enumerate(routes):
            for stop in route:
                stop_to_routes[stop].add(i)

        q = collections.deque()
        visited_routes = set()

        for route_idx in stop_to_routes[source]:
            q.append((route_idx, 1))
            visited_routes.add(route_idx)

        while q:
            current_route_idx, buses_taken = q.popleft()

            for stop in routes[current_route_idx]:
                if stop == target:
                    return buses_taken

                for next_route_idx in stop_to_routes[stop]:
                    if next_route_idx not in visited_routes:
                        visited_routes.add(next_route_idx)
                        q.append((next_route_idx, buses_taken + 1))

        return -1