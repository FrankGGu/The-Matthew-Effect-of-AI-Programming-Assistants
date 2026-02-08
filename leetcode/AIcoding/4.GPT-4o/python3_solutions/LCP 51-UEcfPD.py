def cookDishes(dishes: List[int], time: List[int]) -> int:
    from collections import defaultdict
    import heapq

    dish_time = defaultdict(list)

    for d, t in zip(dishes, time):
        dish_time[d].append(t)

    total_time = 0
    min_heap = []

    for dish in dish_time:
        for t in dish_time[dish]:
            heapq.heappush(min_heap, (t, dish))

    while min_heap:
        t, dish = heapq.heappop(min_heap)
        total_time += t
        if min_heap:
            next_t, next_dish = min_heap[0]
            if next_dish == dish:
                heapq.heappop(min_heap)
                heapq.heappush(min_heap, (next_t + t, next_dish))

    return total_time