def getOrder(orders):
    orders.sort(key=lambda x: (x[1], x[0]))
    heap = []
    result = []
    time = 0
    i = 0
    while i < len(orders) or heap:
        if not heap:
            time = max(time, orders[i][0])
        while i < len(orders) and orders[i][0] <= time:
            heapq.heappush(heap, orders[i])
            i += 1
        if heap:
            result.append(heapq.heappop(heap))
            time += 1
    return result