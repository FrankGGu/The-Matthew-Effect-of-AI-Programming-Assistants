class Solution:
    def distanceBetweenBusStops(self, distance: List[int], start: int, destination: int) -> int:
        total_distance = sum(distance)
        clockwise_distance = 0
        if start > destination:
            start, destination = destination, start
        for i in range(start, destination):
            clockwise_distance += distance[i]
        return min(clockwise_distance, total_distance - clockwise_distance)