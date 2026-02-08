def smallestChair(times: List[List[int]], targetFriend: int) -> int:
    events = []
    for i, (start, end) in enumerate(times):
        events.append((start, 1, i))  # 1 for arrival
        events.append((end, -1, i))    # -1 for departure

    events.sort()

    available_chairs = []
    occupied_chairs = set()
    target_person = times[targetFriend]

    for time, typ, idx in events:
        if typ == 1:  # arrival
            if available_chairs:
                chair = heapq.heappop(available_chairs)
            else:
                chair = len(occupied_chairs)
            occupied_chairs.add(chair)
            if idx == targetFriend:
                return chair
        else:  # departure
            occupied_chairs.remove(idx)
            heapq.heappush(available_chairs, idx)

    return -1