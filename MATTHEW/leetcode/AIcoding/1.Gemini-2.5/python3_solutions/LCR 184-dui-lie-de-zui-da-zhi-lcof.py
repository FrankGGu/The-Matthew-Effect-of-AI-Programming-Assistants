import heapq

class SelfCheckoutSystem:
    def __init__(self, num_counters: int):
        self.counters = [0] * num_counters

    def add_customer(self, processing_time: int):
        earliest_free_time = heapq.heappop(self.counters)
        new_finish_time = earliest_free_time + processing_time
        heapq.heappush(self.counters, new_finish_time)

    def get_total_time(self) -> int:
        if not self.counters:
            return 0
        return max(self.counters)