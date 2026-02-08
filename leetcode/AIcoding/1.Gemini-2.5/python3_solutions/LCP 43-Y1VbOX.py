import heapq

class Solution:
    def trafficCrossing(self, cars: list[list[int]]) -> list[int]:
        n = len(cars)
        car_data = []
        for i, (arrival_time, direction) in enumerate(cars):
            car_data.append((arrival_time, direction, i))

        car_data.sort()

        passing_times = [0] * n

        current_time = 0

        waiting_queue = [] 
        car_idx = 0 

        while car_idx < n or waiting_queue:
            if not waiting_queue and car_idx < n:
                current_time = max(current_time, car_data[car_idx][0])

            while car_idx < n and car_data[car_idx][0] <= current_time:
                arrival, direction, original_idx = car_data[car_idx]
                heapq.heappush(waiting_queue, (direction, original_idx))
                car_idx += 1

            if waiting_queue:
                direction_to_pass, original_idx_to_pass = heapq.heappop(waiting_queue)

                passing_times[original_idx_to_pass] = current_time + 1
                current_time += 1
            else:
                if car_idx == n:
                    break

        return passing_times