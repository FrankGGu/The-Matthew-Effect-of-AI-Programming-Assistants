def pickGifts(gifts: List[int], k: int) -> int:
    import heapq
    max_heap = [-gift for gift in gifts]
    heapq.heapify(max_heap)

    for _ in range(k):
        largest = -heapq.heappop(max_heap)
        largest = int(largest ** 0.5)
        heapq.heappush(max_heap, -largest)

    return -sum(max_heap)