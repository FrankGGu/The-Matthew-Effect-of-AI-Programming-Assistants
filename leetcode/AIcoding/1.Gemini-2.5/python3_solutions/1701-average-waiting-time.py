class Solution:
    def averageWaitingTime(self, customers: list[list[int]]) -> float:
        total_waiting_time = 0
        current_chef_free_time = 0

        for arrival_time, prep_time in customers:
            start_preparation_time = max(arrival_time, current_chef_free_time)
            finish_time = start_preparation_time + prep_time
            waiting_time = finish_time - arrival_time
            total_waiting_time += waiting_time
            current_chef_free_time = finish_time

        return total_waiting_time / len(customers)