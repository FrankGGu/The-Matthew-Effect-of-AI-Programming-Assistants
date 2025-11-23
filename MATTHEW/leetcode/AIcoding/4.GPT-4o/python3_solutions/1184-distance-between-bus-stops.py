class Solution:
    def distanceBetweenBusStops(self, distance: List[int], start: int, destination: int) -> int:
        if start > destination:
            start, destination = destination, start
        total_distance = sum(distance)
        direct_distance = sum(distance[start:destination])
        return min(direct_distance, total_distance - direct_distance)