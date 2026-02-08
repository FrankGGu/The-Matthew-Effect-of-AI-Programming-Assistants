class Solution:
    def findDelayedArrivalTime(self, departureTime: int, duration: int) -> int:
        return (departureTime + duration) % 24