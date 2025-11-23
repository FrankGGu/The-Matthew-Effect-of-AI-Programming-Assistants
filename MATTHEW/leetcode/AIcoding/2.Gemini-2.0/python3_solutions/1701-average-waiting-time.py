class Solution:
    def averageWaitingTime(self, customers: List[List[int]]) -> float:
        wait_time = 0
        current_time = 0
        for arrival_time, service_time in customers:
            if arrival_time > current_time:
                current_time = arrival_time + service_time
            else:
                current_time += service_time
            wait_time += (current_time - arrival_time)
        return wait_time / len(customers)