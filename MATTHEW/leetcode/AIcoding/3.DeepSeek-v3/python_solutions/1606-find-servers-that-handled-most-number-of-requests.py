import heapq

class Solution:
    def busiestServers(self, k: int, arrival: List[int], load: List[int]) -> List[int]:
        available = list(range(k))
        heapq.heapify(available)
        busy = []
        count = [0] * k

        for i, (start, duration) in enumerate(zip(arrival, load)):
            while busy and busy[0][0] <= start:
                _, server = heapq.heappop(busy)
                heapq.heappush(available, i + (server - i) % k)

            if available:
                server = heapq.heappop(available) % k
                heapq.heappush(busy, (start + duration, server))
                count[server] += 1

        max_count = max(count)
        return [i for i, c in enumerate(count) if c == max_count]