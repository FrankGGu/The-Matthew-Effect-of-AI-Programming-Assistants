import collections

class Solution:
    def numBusesToDestination(self, routes: list[list[int]], source: int, target: int) -> int:
        if source == target:
            return 0

        stop_to_routes = collections.defaultdict(list)
        for i, route in enumerate(routes):
            for stop in route:
                stop_to_routes[stop].append(i)

        queue = collections.deque()

        visited_routes = set()

        # Initialize the queue with all routes that contain the source stop
        # The number of buses taken for these initial routes is 1
        # If source is not in any route, stop_to_routes[source] will be empty, and the queue won't be initialized.
        # This will lead to returning -1, which is correct.
        for route_idx in stop_to_routes[source]:
            queue.append((route_idx, 1))
            visited_routes.add(route_idx)

        # Set to keep track of visited stops to optimize traversal.
        # Once a stop is visited, all routes connected through it have been explored
        visited_stops = set()

        while queue:
            curr_route_idx, buses_taken = queue.popleft()

            # Iterate through all stops in the current route
            for stop in routes[curr_route_idx]:
                # If the target stop is found on the current route, we have reached it
                # 'buses_taken' is the minimum number of routes because BFS guarantees shortest path
                if stop == target:
                    return buses_taken

                # If this stop has not been fully processed yet (i.e., its connections to other routes)
                if stop not in visited_stops:
                    visited_stops.add(stop) # Mark this stop as processed

                    # Explore all other routes accessible from this stop
                    for next_route_idx in stop_to_routes[stop]:
                        if next_route_idx not in visited_routes:
                            visited_routes.add(next_route_idx)
                            queue.append((next_route_idx, buses_taken + 1))

        # If the queue becomes empty and the target is not reached, it's impossible
        return -1