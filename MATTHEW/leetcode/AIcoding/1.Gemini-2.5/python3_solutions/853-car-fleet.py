class Solution:
    def carFleet(self, target: int, position: list[int], speed: list[int]) -> int:
        cars = []
        for i in range(len(position)):
            cars.append((position[i], speed[i]))

        cars.sort(key=lambda x: x[0], reverse=True)

        fleets = 0
        current_fleet_arrival_time = -float('inf') 

        for pos, spd in cars:
            time_to_target = (target - pos) / spd

            if time_to_target > current_fleet_arrival_time:
                fleets += 1
                current_fleet_arrival_time = time_to_target

        return fleets