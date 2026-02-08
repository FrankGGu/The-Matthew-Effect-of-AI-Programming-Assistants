def findCrossingTime(n: int, k: int, time: List[List[int]]) -> int:
    import heapq

    time = sorted(time, key=lambda x: x[0])
    min_heap = []
    current_time = 0
    idx = 0
    on_bridge = 0

    while idx < n or on_bridge > 0:
        while min_heap and min_heap[0][0] <= current_time:
            end_time, worker_id = heapq.heappop(min_heap)
            on_bridge -= 1

        while idx < n and len(min_heap) < k:
            heapq.heappush(min_heap, (current_time + time[idx][0] + time[idx][1], idx))
            current_time += time[idx][0]
            idx += 1

        if on_bridge < k and idx < n:
            current_time += time[idx][0]
            on_bridge += 1

    return current_time