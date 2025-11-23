from collections import defaultdict, deque

class Solution:
    def numBusesToDestination(self, routes: list[list[int]], source: int, target: int) -> int:
        if source == target:
            return 0

        stop_to_buses = defaultdict(list)
        for i, route in enumerate(routes):
            for stop in route:
                stop_to_buses[stop].append(i)

        queue = deque([(source, 0)])
        visited_stops = {source}
        visited_buses = set()

        while queue:
            stop, num_buses = queue.popleft()

            for bus_index in stop_to_buses[stop]:
                if bus_index not in visited_buses:
                    visited_buses.add(bus_index)

                    for next_stop in routes[bus_index]:
                        if next_stop == target:
                            return num_buses + 1
                        if next_stop not in visited_stops:
                            visited_stops.add(next_stop)
                            queue.append((next_stop, num_buses + 1))

        return -1