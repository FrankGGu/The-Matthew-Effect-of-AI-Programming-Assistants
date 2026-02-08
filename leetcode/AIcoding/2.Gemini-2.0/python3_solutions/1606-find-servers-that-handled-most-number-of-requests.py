import heapq

class Solution:
    def busiestServers(self, k: int, arrival: list[int], duration: list[int]) -> list[int]:
        available = list(range(k))
        heapq.heapify(available)
        busy = []
        counts = [0] * k

        for i in range(len(arrival)):
            while busy and busy[0][0] <= arrival[i]:
                _, server_idx = heapq.heappop(busy)
                heapq.heappush(available, (server_idx + (arrival[i] - busy[0][0])) % k)

            if available:
                server_idx = heapq.heappop(available)
                counts[server_idx] += 1
                heapq.heappush(busy, (arrival[i] + duration[i], server_idx))

        max_count = max(counts)
        result = []
        for i in range(k):
            if counts[i] == max_count:
                result.append(i)

        return result