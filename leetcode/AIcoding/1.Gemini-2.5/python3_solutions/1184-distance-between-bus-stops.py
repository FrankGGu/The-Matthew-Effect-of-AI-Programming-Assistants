class Solution:
    def distanceBetweenBusStops(self, distance: list[int], start: int, destination: int) -> int:
        total_distance = sum(distance)

        current_path_distance = 0

        if start > destination:
            start, destination = destination, start

        for i in range(start, destination):
            current_path_distance += distance[i]

        return min(current_path_distance, total_distance - current_path_distance)