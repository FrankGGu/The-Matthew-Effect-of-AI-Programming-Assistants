import heapq

class Solution:
    def pickGifts(self, gifts: list[int], k: int) -> int:
        gifts = [-gift for gift in gifts]
        heapq.heapify(gifts)
        for _ in range(k):
            largest = -heapq.heappop(gifts)
            new_gift = int(largest**0.5)
            heapq.heappush(gifts, -new_gift)
        return -sum(gifts)