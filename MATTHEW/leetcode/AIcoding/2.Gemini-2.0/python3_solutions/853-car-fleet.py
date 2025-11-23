class Solution:
    def carFleet(self, target: int, position: list[int], speed: list[int]) -> int:
        cars = sorted(zip(position, speed))
        times = [(target - p) / s for p, s in cars]
        fleets = 0
        max_time = 0
        for time in reversed(times):
            if time > max_time:
                fleets += 1
                max_time = time
        return fleets