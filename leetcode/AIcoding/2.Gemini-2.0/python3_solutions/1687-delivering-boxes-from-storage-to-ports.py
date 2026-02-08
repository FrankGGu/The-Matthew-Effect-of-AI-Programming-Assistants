def boxDelivering(boxes, portsCount, maxBoxes, maxWeight):
    n = len(boxes)
    ports = [box[0] for box in boxes]
    weights = [box[1] for box in boxes]

    prefix_sum_weight = [0] * (n + 1)
    for i in range(n):
        prefix_sum_weight[i + 1] = prefix_sum_weight[i] + weights[i]

    changes = [0] * (n + 1)
    for i in range(1, n):
        if ports[i] != ports[i - 1]:
            changes[i + 1] = changes[i] + 1
        else:
            changes[i + 1] = changes[i]

    dp = [float('inf')] * (n + 1)
    dp[0] = 0
    deque = [0]
    for i in range(1, n + 1):
        while deque and (i - deque[0] > maxBoxes or prefix_sum_weight[i] - prefix_sum_weight[deque[0]] > maxWeight):
            deque.pop(0)

        if deque:
            dp[i] = dp[deque[0]] + changes[i] - changes[deque[0] + 1] + 2

        while deque and dp[deque[-1]] - changes[deque[-1] + 1] >= dp[i] - changes[i + 1]:
            deque.pop()
        deque.append(i)

    return dp[n]