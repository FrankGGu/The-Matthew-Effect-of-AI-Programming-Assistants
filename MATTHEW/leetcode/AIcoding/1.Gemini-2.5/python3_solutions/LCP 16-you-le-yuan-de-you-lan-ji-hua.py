class FenwickTree:
    def __init__(self, size):
        self.bit = [0] * (size + 1)
        self.size = size

    def update(self, idx, delta):
        # idx is 1-based
        while idx <= self.size:
            self.bit[idx] += delta
            idx += idx & (-idx)

    def query(self, idx):
        # idx is 1-based, returns sum from 1 to idx
        total = 0
        while idx > 0:
            total += self.bit[idx]
            idx -= idx & (-idx)
        return total

class Solution:
    def getAmmountOfRides(self, n: int, rides: list[list[int]], k: int, queries: list[list[int]]) -> list[int]:
        min_rides_to_take = n - k

        # Collect all unique end_times for coordinate compression
        all_end_times = set()
        for r_start, r_end in rides:
            all_end_times.add(r_end)
        for q_start, q_end in queries:
            all_end_times.add(q_end)

        sorted_end_times = sorted(list(all_end_times))
        end_time_to_idx = {val: i + 1 for i, val in enumerate(sorted_end_times)}

        # Prepare events for sweep line
        # Event format: (time, type, other_coord, original_index_for_query)
        # type 0 for ride (add to BIT), type 1 for query (query BIT)
        # Sort by time descending. If times are equal, process rides before queries.
        events = []
        for i, (r_start, r_end) in enumerate(rides):
            events.append((r_start, 0, end_time_to_idx[r_end], -1))

        for i, (q_start, q_end) in enumerate(queries):
            events.append((q_start, 1, end_time_to_idx[q_end], i))

        events.sort(key=lambda x: (-x[0], x[1]))

        ft = FenwickTree(len(sorted_end_times))

        ans = [-1] * len(queries)

        for time, event_type, compressed_end_time, original_idx in events:
            if event_type == 0: # Ride event
                ft.update(compressed_end_time, 1)
            else: # Query event
                count = ft.query(compressed_end_time)
                if count >= min_rides_to_take:
                    ans[original_idx] = count

        return ans